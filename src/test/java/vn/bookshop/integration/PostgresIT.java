package vn.bookshop.integration;
import java.util.*;
import java.util.concurrent.*;
import org.junit.jupiter.api.*;
import vn.bookshop.cart.domain.Cart;
import vn.bookshop.cart.application.*;
import vn.bookshop.infrastructure.persistence.*;
import vn.bookshop.support.MemoryStore;
import static org.junit.jupiter.api.Assertions.*;
class PostgresIT {
 DatabaseFixture db;PostgresCartAdapter carts;PostgresCatalogAdapter catalog;
 @BeforeEach void setup(){db=new DatabaseFixture();carts=new PostgresCartAdapter(db.jdbc,db.tx);catalog=new PostgresCatalogAdapter(db.jdbc);}
 @AfterEach void cleanup(){if(db!=null)db.close();}
 private void contract(CartPort port){
  Cart c=port.open("guest-a");assertEquals(c.id(),port.open("guest-a").id());
  assertTrue(port.loadOwned(c.id(),"guest-b").isEmpty());
  assertTrue(port.save(c.changeLine("S001",2),0));
  assertFalse(port.save(c.changeLine("S001",9),0));
  Cart read=port.loadOwned(c.id(),"guest-a").orElseThrow();assertEquals(1,read.version());assertEquals(2,read.quantity("S001"));
  assertThrows(IllegalArgumentException.class,()->port.save(read,0));
  assertTrue(port.save(read.changeLine("S001",0),1));assertTrue(port.loadOwned(c.id(),"guest-a").orElseThrow().lines().isEmpty());
 }
 @Test void sameContractForMemoryAndPostgres(){contract(new MemoryStore());contract(carts);}
 @Test void persistenceErrorRollsBackVersionAndLines(){
  Cart c=carts.open("rollback");assertTrue(carts.save(c.changeLine("S001",2),0));
  Cart read=carts.loadOwned(c.id(),"rollback").orElseThrow();
  assertThrows(RuntimeException.class,()->carts.save(read.changeLine("ABSENT",1),1));
  Cart after=carts.loadOwned(c.id(),"rollback").orElseThrow();assertEquals(read.version(),after.version());assertEquals(read.lines(),after.lines());
 }
 @Test void concurrentUpdatesHaveExactlyOneWinner() throws Exception {
  Cart c=carts.open("concurrent");var gate=new CyclicBarrier(2);
  try(var pool=Executors.newFixedThreadPool(2)){
   Callable<Boolean> a=()->{gate.await(5,TimeUnit.SECONDS);return carts.save(c.changeLine("S001",2),0);};
   Callable<Boolean> b=()->{gate.await(5,TimeUnit.SECONDS);return carts.save(c.changeLine("S001",3),0);};
   var fa=pool.submit(a);var fb=pool.submit(b);assertNotEquals(fa.get(10,TimeUnit.SECONDS),fb.get(10,TimeUnit.SECONDS));
  }
  Cart after=carts.loadOwned(c.id(),"concurrent").orElseThrow();assertEquals(1,after.version());assertTrue(Set.of(2,3).contains(after.quantity("S001")));
  assertEquals(10,catalog.find("S001").orElseThrow().onHand());assertEquals(0,catalog.find("S001").orElseThrow().reserved());
 }
 @Test void sameUseCaseWorksAgainstPostgresAndFreshReadsSeeCommit(){
  Cart c=carts.open("usecase");List<ChangeCartResponse> out=new ArrayList<>();
  new ChangeCartInteractor(carts,catalog,new PricingService(catalog),out::add).execute(new ChangeCartRequest(c.id(),"usecase","S001","2",0,ChangeMode.ADD));
  assertEquals(CartStatus.OK,out.getFirst().status());assertEquals("240000",out.getFirst().cart().totalVnd().toPlainString());
  var second=new PostgresCartAdapter(db.jdbc,db.tx);assertEquals(2,second.loadOwned(c.id(),"usecase").orElseThrow().quantity("S001"));
 }
}
