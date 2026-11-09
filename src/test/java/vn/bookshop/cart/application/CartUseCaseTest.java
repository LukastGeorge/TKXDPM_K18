package vn.bookshop.cart.application;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import java.math.BigDecimal;
import java.util.*;
import vn.bookshop.cart.domain.Cart;
import vn.bookshop.catalog.domain.Book;
import vn.bookshop.support.MemoryStore;
import static org.junit.jupiter.api.Assertions.*;

class CartUseCaseTest {
    MemoryStore store;Cart initial;List<ChangeCartResponse> responses;
    @BeforeEach void setup(){
        store=new MemoryStore();responses=new ArrayList<>();
        store.books.put("S001",new Book("S001","Java căn bản","Tác giả 1","NXB thử","TL01","Mô tả","/cover.svg",new BigDecimal("120000"),10,0,true));
        store.books.put("S002",new Book("S002","Thiết kế phần mềm","Tác giả 2","NXB thử","TL01","Mô tả","/cover.svg",new BigDecimal("180000"),5,0,true));
        initial=store.open("A");
    }
    ChangeCartResponse execute(String owner,String sku,String qty,long version,ChangeMode mode){
        responses.clear();new ChangeCartInteractor(store,store,new PricingService(store),responses::add)
            .execute(new ChangeCartRequest(initial.id(),owner,sku,qty,version,mode));
        assertEquals(1,responses.size());return responses.getFirst();
    }
    @Test void additionUsesBackendPriceAndRemovalKeepsOtherLine(){
        assertEquals(new BigDecimal("240000"),execute("A","S001","2",0,ChangeMode.ADD).cart().totalVnd());
        assertEquals(new BigDecimal("420000"),execute("A","S002","1",1,ChangeMode.ADD).cart().totalVnd());
        var r=execute("A","S001","0",2,ChangeMode.SET);
        assertEquals(CartStatus.OK,r.status());assertEquals(new BigDecimal("180000"),r.cart().totalVnd());
        assertEquals("S002",r.cart().lines().getFirst().sku());assertEquals(3,r.cart().version());
        assertEquals(10,store.books.get("S001").available());
    }
    @ParameterizedTest @CsvSource(value={"-1|Số lượng không được âm","1.5|Số lượng phải là số nguyên","abc|Số lượng phải là số nguyên","''|Số lượng không được để trống","2147483648|Số lượng quá lớn"},delimiter='|')
    void invalidQuantityPreservesCart(String qty,String message){
        var r=execute("A","S001",qty,0,ChangeMode.SET);
        assertEquals(CartStatus.INVALID_INPUT,r.status());assertEquals(message,r.message());
        assertTrue(store.loadOwned(initial.id(),"A").orElseThrow().lines().isEmpty());assertEquals(0,store.saves);
    }
    @Test void otherOwnerReceivesNoCartAndCannotWrite(){
        var r=execute("B","S001","1",0,ChangeMode.SET);
        assertEquals(CartStatus.FORBIDDEN,r.status());assertNull(r.cart());assertEquals(0,store.saves);
    }
    @Test void staleVersionAndConcurrentSaveDoNotOverwrite(){
        execute("A","S001","2",0,ChangeMode.SET);
        assertEquals(CartStatus.CONFLICT,execute("A","S001","3",0,ChangeMode.SET).status());
        store.rejectSave=true;
        assertEquals(CartStatus.CONFLICT,execute("A","S001","3",1,ChangeMode.SET).status());
        assertEquals(2,store.loadOwned(initial.id(),"A").orElseThrow().quantity("S001"));
    }
    @Test void rejectsMissingAndOverAvailabilityButAcceptsExactBoundary(){
        assertEquals(CartStatus.NOT_FOUND,execute("A","MISSING","1",0,ChangeMode.ADD).status());
        assertEquals(CartStatus.EXCEEDS_STOCK,execute("A","S001","11",0,ChangeMode.SET).status());
        assertEquals(CartStatus.OK,execute("A","S001","10",0,ChangeMode.SET).status());
        assertEquals(CartStatus.EXCEEDS_STOCK,execute("A","S001","2147483647",1,ChangeMode.ADD).status());
    }
    @Test void canRemoveEvenAfterStockBecomesZero(){
        execute("A","S001","2",0,ChangeMode.SET);Book old=store.books.get("S001");
        store.books.put("S001",new Book(old.sku(),old.title(),old.author(),old.publisher(),old.category(),old.description(),old.coverPath(),old.priceVnd(),0,0,true));
        assertEquals(CartStatus.OK,execute("A","S001","0",1,ChangeMode.SET).status());
    }
    @Test void readOpensCartAndUsesCurrentPrices(){
        new CartQueryInteractor(store,new PricingService(store),responses::add).execute(new CartQueryRequest("A"));
        assertEquals(1,responses.size());assertEquals(BigDecimal.ZERO,responses.getFirst().cart().totalVnd());
    }
    @Test void sameUseCaseWorksWithTwoOutputImplementations(){
        List<ChangeCartResponse> first=new ArrayList<>();
        class LastResponse implements ChangeCartOutputBoundary {ChangeCartResponse value;public void present(ChangeCartResponse r){value=r;}}
        LastResponse second=new LastResponse();
        new CartQueryInteractor(store,new PricingService(store),first::add).execute(new CartQueryRequest("A"));
        new CartQueryInteractor(store,new PricingService(store),second).execute(new CartQueryRequest("A"));
        assertEquals(first.getFirst(),second.value);assertEquals(CartStatus.OK,second.value.status());
    }
}
