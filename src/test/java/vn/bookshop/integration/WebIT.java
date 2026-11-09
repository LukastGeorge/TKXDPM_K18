package vn.bookshop.integration;
import java.net.*;
import java.net.http.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.*;
import org.junit.jupiter.api.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext;
import vn.bookshop.delivery.BookshopApplication;
import static org.junit.jupiter.api.Assertions.*;
class WebIT {
 static DatabaseFixture db;static ServletWebServerApplicationContext app;static String base;
 @BeforeAll static void start(){
  db=new DatabaseFixture();app=(ServletWebServerApplicationContext)SpringApplication.run(BookshopApplication.class,
   "--server.port=0","--spring.datasource.url="+db.url,"--spring.datasource.username="+db.user,"--spring.datasource.password="+db.password);
  base="http://127.0.0.1:"+app.getWebServer().getPort();
 }
 @AfterAll static void stop(){if(app!=null)app.close();if(db!=null)db.close();}
 HttpClient client(){return HttpClient.newBuilder().cookieHandler(new CookieManager(null,CookiePolicy.ACCEPT_ALL)).build();}
 HttpResponse<String> get(HttpClient c,String path)throws Exception{return c.send(HttpRequest.newBuilder(URI.create(base+path)).GET().build(),HttpResponse.BodyHandlers.ofString());}
 String value(String html,String name){Matcher m=Pattern.compile("name=\""+name+"\"[^>]*value=\"([^\"]*)\"").matcher(html);assertTrue(m.find(),name+" field missing");return m.group(1);}
 String action(String html){Matcher m=Pattern.compile("action=\"(/cart/[a-f0-9-]+)\"").matcher(html);assertTrue(m.find());return m.group(1);}
 HttpResponse<String> post(HttpClient c,String path,Map<String,String> fields)throws Exception{
  String form=fields.entrySet().stream().map(e->URLEncoder.encode(e.getKey(),StandardCharsets.UTF_8)+"="+URLEncoder.encode(e.getValue(),StandardCharsets.UTF_8)).reduce((a,b)->a+"&"+b).orElse("");
  return c.send(HttpRequest.newBuilder(URI.create(base+path)).header("Content-Type","application/x-www-form-urlencoded").POST(HttpRequest.BodyPublishers.ofString(form)).build(),HttpResponse.BodyHandlers.ofString());
 }
 Map<String,String> fields(String html,String qty){var f=new HashMap<String,String>();f.put("_csrf",value(html,"_csrf"));f.put("version",value(html,"version"));f.put("sku","S001");f.put("quantity",qty);f.put("mode","ADD");return f;}
 @Test void listDetailAddUpdateRemoveThroughHttpAndDatabase()throws Exception{
  var c=client();var list=get(c,"/books");assertEquals(200,list.statusCode());assertTrue(list.body().contains("Java căn bản"));
  var detail=get(c,"/books/S001");assertEquals(200,detail.statusCode());assertTrue(detail.body().contains("Tác giả"));
  var f=fields(detail.body(),"2");f.put("price","1");f.put("owner","forged");
  assertEquals(303,post(c,action(detail.body()),f).statusCode());var cart=get(c,"/cart");assertTrue(cart.body().contains("240.000"));
  var edit=fields(cart.body(),"3");edit.put("mode","SET");assertEquals(303,post(c,action(cart.body()),edit).statusCode());assertTrue(get(c,"/cart").body().contains("360.000"));
  var latest=get(c,"/cart");var remove=fields(latest.body(),"0");remove.put("mode","SET");assertEquals(303,post(c,action(latest.body()),remove).statusCode());
  assertTrue(get(c,"/cart").body().contains("Giỏ hàng trống"));assertEquals(10,db.jdbc.queryForObject("select on_hand from books where sku='S001'",Integer.class));
 }
 @Test void csrfAndForeignCartBlocked()throws Exception{
  var a=client();var b=client();String ha=get(a,"/books").body();String hb=get(b,"/books").body();
  var f=fields(ha,"2");f.remove("_csrf");assertEquals(403,post(a,action(ha),f).statusCode());
  assertEquals(303,post(a,action(ha),fields(ha,"2")).statusCode());
  assertEquals(403,post(b,action(ha),fields(hb,"1")).statusCode());assertTrue(get(b,"/cart").body().contains("Giỏ hàng trống"));assertTrue(get(a,"/cart").body().contains("240.000"));
 }
 @Test void invalidQuantityStaleVersionMissingBookAndMalformedRequest()throws Exception{
  var c=client();String h=get(c,"/books").body();var f=fields(h,"abc");assertEquals(400,post(c,action(h),f).statusCode());
  assertEquals(303,post(c,action(h),fields(h,"1")).statusCode());assertEquals(409,post(c,action(h),fields(h,"2")).statusCode());
  assertEquals(404,get(c,"/books/ABSENT").statusCode());f=fields(h,"1");f.put("version","bad");assertEquals(400,post(c,action(h),f).statusCode());
  assertEquals(400,post(c,"/cart/not-uuid",fields(h,"1")).statusCode());
 }
}
