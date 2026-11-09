package vn.bookshop.adapters.web;
import java.util.UUID;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.bookshop.catalog.application.*;
import vn.bookshop.cart.application.*;
/** Parses HTTP only; prices, quantities and ownership are enforced by use cases. */
@Controller
public class BookshopController {
 private final CatalogInputBoundary catalog;private final CartQueryInputBoundary query;private final ChangeCartInputBoundary change;
 private final CatalogPresenter catalogOut;private final CartPresenter cartOut;
 /** All use cases and request-scoped output adapters are provided by the composition root. */
 public BookshopController(CatalogInputBoundary catalog,CartQueryInputBoundary query,ChangeCartInputBoundary change,CatalogPresenter catalogOut,CartPresenter cartOut){this.catalog=catalog;this.query=query;this.change=change;this.catalogOut=catalogOut;this.cartOut=cartOut;}
 /** Canonical catalog route, no data mutation. */
 @GetMapping("/") public String home(){return "redirect:/books";}
 /** Renders visible books and the guest cart token/version used by the add forms. May create an empty cart. */
 @GetMapping("/books") public String books(HttpSession session,Model model,HttpServletResponse http){
  catalog.execute(new CatalogRequest(null));model.addAttribute("books",catalogOut.response().books());
  if(!loadCart(session,model)){return failure(model,http,503,"Không thể tải giỏ hàng. Vui lòng thử lại.");}return "books";
 }
 /** Renders a visible SKU or 404. Unknown/hidden books have no add form. */
 @GetMapping("/books/{sku}") public String detail(@PathVariable String sku,HttpSession session,Model model,HttpServletResponse http){
  catalog.execute(new CatalogRequest(sku));var result=catalogOut.response();
  if(!result.found())return failure(model,http,404,result.message());model.addAttribute("book",result.selected());
  if(!loadCart(session,model))return failure(model,http,503,"Không thể tải giỏ hàng. Vui lòng thử lại.");return "detail";
 }
 /** Reads backend prices and current quantities; never reserves stock. */
 @GetMapping("/cart") public String cart(HttpSession session,Model model,HttpServletResponse http){
  if(!loadCart(session,model))return failure(model,http,503,"Không thể tải giỏ hàng. Vui lòng thử lại.");return "cart";
 }
 /** Parses identifiers/version/mode; user owner and prices are never accepted from the browser. */
 @PostMapping("/cart/{id}") public String change(@PathVariable String id,@RequestParam String sku,@RequestParam String quantity,@RequestParam String version,@RequestParam String mode,HttpSession session,Model model,HttpServletResponse http){
  UUID cartId;long expected;ChangeMode operation;
  try{cartId=UUID.fromString(id);expected=Long.parseLong(version);operation=ChangeMode.valueOf(mode);}catch(IllegalArgumentException e){return failure(model,http,400,"Yêu cầu giỏ hàng không hợp lệ.");}
  change.execute(new ChangeCartRequest(cartId,session.getId(),sku,quantity,expected,operation));var result=cartOut.response();
  if(result.status()==CartStatus.OK){http.setStatus(303);http.setHeader("Location","/cart");return null;}
  int code=switch(result.status()){case FORBIDDEN->403;case NOT_FOUND->404;case CONFLICT->409;case UNAVAILABLE->503;default->400;};
  return failure(model,http,code,result.message());
 }
 /** Executes the read input with the server-session owner; returns false on application failure. */
 private boolean loadCart(HttpSession session,Model model){query.execute(new CartQueryRequest(session.getId()));var r=cartOut.response();if(r.status()!=CartStatus.OK)return false;model.addAttribute("cart",r.cart());return true;}
 /** Returns a safe message without internal exceptions or another owner's data. */
 private String failure(Model model,HttpServletResponse http,int status,String message){http.setStatus(status);model.addAttribute("status",status);model.addAttribute("message",message);return "problem";}
}
