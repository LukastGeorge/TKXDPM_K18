package vn.bookshop.acceptance;

import io.cucumber.java.Before;
import io.cucumber.java.en.*;
import io.cucumber.datatable.DataTable;
import java.math.BigDecimal;
import java.util.*;
import vn.bookshop.catalog.application.*;
import vn.bookshop.catalog.domain.Book;
import vn.bookshop.cart.application.*;
import vn.bookshop.cart.domain.Cart;
import vn.bookshop.support.MemoryStore;
import static org.junit.jupiter.api.Assertions.*;

/** Fixture setup and assertions only. All When cart/catalog actions call application boundaries. */
public class BookshopSteps {
 private MemoryStore store;private ChangeCartResponse result;private CatalogResponse catalog;
 private String owner;private int originalH;private int originalR;
 @Before public void setup(){store=new MemoryStore();owner="guest";}
 private Book fixture(String sku,String name,int price,int h,int r){return new Book(sku,name,"Tác giả thử","NXB thử","TL01","Mô tả thử","/cover.svg",BigDecimal.valueOf(price),h,r,true);}
 private Cart cart(String who){return store.open(who);}
 private void arrange(String who,Map<String,Integer> quantities,long version){Cart c=cart(who);store.carts.put(c.id(),new Cart(c.id(),who,version,quantities));}
 private void ensureBook(){store.books.putIfAbsent("S001",fixture("S001","Java căn bản",120000,10,0));}
 private void change(String who,UUID id,String sku,String quantity,long version,ChangeMode mode){
  ChangeCartInputBoundary input=new ChangeCartInteractor(store,store,new PricingService(store),r->result=r);
  input.execute(new ChangeCartRequest(id,who,sku,quantity,version,mode));
 }
 private void change(String sku,String quantity,ChangeMode mode){Cart c=cart(owner);change(owner,c.id(),sku,quantity,c.version(),mode);}
 private CartSnapshot view(String who){List<ChangeCartResponse> output=new ArrayList<>();
  CartQueryInputBoundary input=new CartQueryInteractor(store,new PricingService(store),output::add);
  input.execute(new CartQueryRequest(who));assertEquals(CartStatus.OK,output.getFirst().status());return output.getFirst().cart();}
 private CartLineSnapshot line(String sku){return view(owner).lines().stream().filter(l->l.sku().equals(sku)).findFirst().orElseThrow();}

 @Given("^dữ liệu gốc sách (\\S+) tên \"([^\"]+)\", giá niêm yết (\\d+) VND, tồn ban đầu (\\d+), giữ chỗ (\\d+), (.+) và ảnh mô tả đang hiển thị$")
 public void book(String sku,String name,int price,int h,int r,String metadata){
  String[] fields=metadata.split(", ");
  store.books.put(sku,new Book(sku,name,fields[0],fields[1],fields[2].replace("thể loại ",""),"Mô tả thử","/cover.svg",BigDecimal.valueOf(price),h,r,true));originalH=h;originalR=r;
 }
 @Given("cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản") public void regularFixture(){assertNotNull(store);}
 @Given("tôi là guest chưa đăng nhập") public void guest(){owner="guest";}
 @Given("guest có giỏ hàng trống") public void empty(){arrange(owner,Map.of(),0);}
 @Given("tất cả sách trong danh mục đã ngừng hiển thị") public void emptyCatalog(){store.books.clear();}
 @Given("danh mục thử không có mã sách KHONG_TON_TAI") public void missingCatalog(){store.books.remove("KHONG_TON_TAI");}
 @Given("guest có {int} quyển {string} trong giỏ") public void existing(int qty,String sku){arrange(owner,Map.of(sku,qty),0);}
 @Given("guest chỉ có {int} quyển {string} trong giỏ") public void only(int qty,String sku){existing(qty,sku);}
 @Given("guest có {int} quyển {string} và {int} quyển {string} trong giỏ") public void two(int a,String x,int b,String y){arrange(owner,Map.of(x,a,y,b),0);}
 @Given("guest có giỏ hàng") public void tableCart(DataTable table){Map<String,Integer> lines=new HashMap<>();for(var row:table.asMaps())lines.put(row.get("mã sách"),Integer.parseInt(row.get("số lượng")));arrange(owner,lines,0);}
 @Given("guest A và guest B dùng hai phiên truy cập độc lập") public void twoGuests(){cart("A");cart("B");}
 @Given("guest A đã thêm {int} quyển {string} vào giỏ") public void aHas(int qty,String sku){arrange("A",Map.of(sku,qty),0);}
 @When("tôi mở danh sách sách") public void catalogList(){new CatalogInteractor(store,r->catalog=r).execute(new CatalogRequest(null));}
 @When("guest mở danh sách sách") public void guestCatalog(){catalogList();}
 @When("guest chọn xem chi tiết sách {string} từ danh sách") public void detail(String sku){new CatalogInteractor(store,r->catalog=r).execute(new CatalogRequest(sku));}
 @When("guest mở chi tiết sách có mã {string}") public void detailMissing(String sku){detail(sku);}
 @When("^guest chọn mua (\\d+) quyển \"([^\"]+)\" từ (.+)$") public void addFrom(int q,String sku,String location){assertTrue(List.of("danh sách sách","màn hình chi tiết").contains(location));change(sku,String.valueOf(q),ChangeMode.ADD);}
 @When("guest chọn mua {int} quyển {string}") public void add(int q,String sku){change(sku,String.valueOf(q),ChangeMode.ADD);}
 @When("guest chọn mua thêm {int} quyển {string}") public void addAgain(int q,String sku){add(q,sku);}
 @When("guest mở giỏ hàng") public void show(){new CartQueryInteractor(store,new PricingService(store),r->result=r).execute(new CartQueryRequest(owner));}
 @When("guest B mở giỏ hàng của phiên B") public void bShow(){owner="B";show();}
 @When("guest cập nhật số lượng {string} thành {int}") public void set(String sku,int qty){change(sku,String.valueOf(qty),ChangeMode.SET);}
 @When("guest gửi yêu cầu đổi số lượng {string} thành {string}") public void setRaw(String sku,String qty){change(sku,qty,ChangeMode.SET);}

 @Then("tôi thấy các sách {string}, {string} và {string}") public void titles(String a,String b,String c){assertEquals(List.of(a,b,c),catalog.books().stream().map(Book::sku).toList());}
 @Then("mỗi sách có mã, tên, ảnh đại diện, giá và trạng thái còn hàng hoặc hết hàng") public void bookFields(){for(Book b:catalog.books()){assertFalse(b.title().isBlank());assertFalse(b.coverPath().isBlank());assertTrue(b.priceVnd().signum()>=0);assertTrue(b.available()>=0);}}
 @Then("hệ thống không yêu cầu tôi đăng nhập để xem danh sách") public void publicList(){assertTrue(catalog.found());}
 @Then("hệ thống thông báo chưa có sách") public void noBooks(){assertTrue(catalog.books().isEmpty());}
 @Then("không hiển thị lỗi hệ thống hoặc một sản phẩm giả") public void noFake(){assertTrue(catalog.found());assertTrue(catalog.books().isEmpty());}
 @Then("hệ thống hiển thị đúng sách {string}") public void rightBook(String sku){assertEquals(sku,catalog.selected().sku());}
 @Then("hiển thị tên, tác giả, nhà xuất bản, thể loại, mô tả, ảnh, giá và tình trạng hàng") public void details(){Book b=catalog.selected();assertAll(()->assertFalse(b.author().isBlank()),()->assertFalse(b.publisher().isBlank()),()->assertFalse(b.category().isBlank()),()->assertFalse(b.description().isBlank()),()->assertFalse(b.coverPath().isBlank()));}
 @Then("giá hiển thị là {int} VND") public void detailPrice(int price){assertEquals(BigDecimal.valueOf(price),catalog.selected().priceVnd());}
 @Then("hệ thống thông báo không tìm thấy sách") public void notFound(){assertFalse(catalog.found());assertEquals("Không tìm thấy sách",catalog.message());}
 @Then("không cho thêm mã sách đó vào giỏ") public void missingCannotBuy(){assertNull(catalog.selected());}
 @Then("giỏ có đúng một dòng sách {string} với số lượng {int}") public void oneLine(String sku,int qty){assertEquals(CartStatus.OK,result.status());assertEquals(1,view(owner).lines().size());assertEquals(qty,line(sku).quantity());}
 @Then("thành tiền của dòng là {int} VND") public void linePrice(int total){assertEquals(BigDecimal.valueOf(total),view(owner).lines().getFirst().totalVnd());}
 @Then("hệ thống không bắt guest đăng nhập để thêm vào giỏ") public void publicAdd(){assertEquals(CartStatus.OK,result.status());}
 @Then("giỏ chỉ có một dòng {string} với số lượng {int}") public void single(String sku,int qty){oneLine(sku,qty);}
 @Then("hệ thống thông báo sách hết hàng") public void noStock(){assertEquals(CartStatus.OUT_OF_STOCK,result.status());}
 @Then("giỏ vẫn trống") public void stillEmpty(){assertTrue(view(owner).lines().isEmpty());}
 @Then("hệ thống thông báo số lượng vượt tồn kho khả dụng {int}") public void excess(int a){assertEquals(CartStatus.EXCEEDS_STOCK,result.status());assertEquals("Số lượng vượt tồn kho khả dụng "+a,result.message());}
 @Then("giỏ vẫn có đúng {int} quyển {string}") public void unchangedQty(int q,String sku){assertEquals(q,line(sku).quantity());}
 @Then("giỏ hiển thị {int} dòng sách với tổng số lượng {int}") public void counts(int count,int quantity){assertEquals(count,view(owner).lines().size());assertEquals(quantity,view(owner).lines().stream().mapToInt(CartLineSnapshot::quantity).sum());}
 @Then("dòng {string} có thành tiền {int} VND") public void oneTotal(String sku,int amount){assertEquals(BigDecimal.valueOf(amount),line(sku).totalVnd());}
 @Then("tổng tiền sách là {int} VND") public void total(int amount){assertEquals(BigDecimal.valueOf(amount),view(owner).totalVnd());}
 @Then("hệ thống thông báo giỏ hàng trống") public void emptyMessage(){assertTrue(result.cart().lines().isEmpty());}
 @Then("không cho tạo đơn từ giỏ trống") public void noOrder(){assertTrue(result.cart().lines().isEmpty());/* No ordering capability exists in S1. */}
 @Then("giỏ của guest B trống") public void bEmpty(){assertTrue(view("B").lines().isEmpty());}
 @Then("giỏ của guest A vẫn có {int} quyển {string}") public void aUnchanged(int q,String sku){assertEquals(q,cart("A").quantity(sku));}
 @Then("giỏ có {int} quyển {string}") public void has(int q,String sku){assertEquals(q,line(sku).quantity());}
 @Then("thành tiền và tổng tiền sách đều là {int} VND") public void sameTotal(int amount){linePrice(amount);total(amount);}
 @Then("giỏ không còn dòng {string}") public void removed(String sku){assertEquals(0,cart(owner).quantity(sku));}
 @Then("giỏ vẫn có {int} quyển {string}") public void otherLine(int q,String sku){has(q,sku);}
 @Then("giỏ trở thành trống") public void becameEmpty(){stillEmpty();}
 @Then("hệ thống thông báo {string}") public void errorText(String expected){assertEquals(expected,result.message());assertNotEquals(CartStatus.OK,result.status());}
 @Then("giỏ vẫn có {int} quyển {string} với thành tiền {int} VND") public void errorPreserves(int q,String sku,int price){has(q,sku);oneTotal(sku,price);}
 @Then("giỏ có {int} quyển {string} với thành tiền {int} VND") public void boundary(int q,String sku,int price){assertEquals(CartStatus.OK,result.status());has(q,sku);oneTotal(sku,price);}
 @Then("thao tác sửa giỏ không làm tồn kho giảm") public void noReserve(){Book b=store.books.get("S001");assertEquals(originalH,b.onHand());assertEquals(originalR,b.reserved());}
 @Given("S001 có tồn thực tế 1, giữ chỗ 0 và hai guest A B có giỏ riêng trống") public void finalItem(){store.books.put("S001",fixture("S001","Java",120000,1,0));cart("A");cart("B");}
 @Given("guest A đã thêm 1 S001 vào giỏ A, kho vẫn thực tế 1 và giữ chỗ 0") public void firstChoice(){arrange("A",Map.of("S001",1),1);}
 @When("guest B thêm 1 S001 vào giỏ B") public void secondChoice(){owner="B";add(1,"S001");}
 @Then("giỏ A và giỏ B mỗi giỏ có 1 S001") public void both(){assertEquals(1,cart("A").quantity("S001"));assertEquals(1,cart("B").quantity("S001"));}
 @Then("kho vẫn thực tế 1, giữ chỗ 0 và khả dụng 1") public void actual(){Book b=store.books.get("S001");assertEquals(1,b.onHand());assertEquals(0,b.reserved());assertEquals(1,b.available());}
 @Then("chưa có đơn hàng hoặc cam kết bán hàng cho bất kỳ guest nào") public void uncommitted(){assertEquals(0,store.books.get("S001").reserved());}
 @Given("guest A có 2 quyển S001 và guest B có giỏ riêng trống") public void attackSetup(){ensureBook();arrange("A",Map.of("S001",2),1);cart("B");}
 @When("guest B gửi thay số lượng trên mã giỏ A thành 1") public void foreign(){change("B",cart("A").id(),"S001","1",1,ChangeMode.SET);}
 @Then("phản hồi từ chối không chứa dữ liệu giỏ A") public void forbidden(){assertEquals(CartStatus.FORBIDDEN,result.status());assertNull(result.cart());}
 @Then("giỏ A vẫn có 2 S001 và giỏ B vẫn trống") public void noCrossWrite(){assertEquals(2,cart("A").quantity("S001"));assertTrue(cart("B").lines().isEmpty());}
 @Given("guest có giỏ S001 số lượng 2 ở phiên bản 1") public void oldVersion(){ensureBook();arrange(owner,Map.of("S001",2),1);}
 @Given("một yêu cầu khác đã đổi S001 thành 3 ở phiên bản 2") public void newer(){arrange(owner,Map.of("S001",3),2);}
 @When("guest gửi thay S001 thành 4 với phiên bản 1") public void stale(){change(owner,cart(owner).id(),"S001","4",1,ChangeMode.SET);}
 @Then("phản hồi xung đột yêu cầu tải lại giỏ") public void conflict(){assertEquals(CartStatus.CONFLICT,result.status());}
 @Then("giỏ vẫn có 3 S001 ở phiên bản 2") public void unchangedVersion(){assertEquals(3,cart(owner).quantity("S001"));assertEquals(2,cart(owner).version());}
}
