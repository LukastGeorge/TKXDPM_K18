package vn.bookshop.catalog.application;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.util.ArrayList;
import vn.bookshop.catalog.domain.Book;
import vn.bookshop.support.MemoryStore;
import static org.junit.jupiter.api.Assertions.*;
class CatalogTest {
 @Test void listDetailAndMissingArePublicReadOnlyResults(){
  MemoryStore store=new MemoryStore();store.books.put("S001",new Book("S001","Java","A","NXB","TL01","Mô tả","/cover.svg",new BigDecimal("120000"),10,2,true));
  var results=new ArrayList<CatalogResponse>();var usecase=new CatalogInteractor(store,results::add);
  usecase.execute(new CatalogRequest(null));assertEquals(1,results.getLast().books().size());
  usecase.execute(new CatalogRequest("S001"));assertEquals(8,results.getLast().selected().available());
  usecase.execute(new CatalogRequest("MISSING"));assertFalse(results.getLast().found());assertNull(results.getLast().selected());
  assertEquals(3,results.size());assertEquals(0,store.saves);
 }
}
