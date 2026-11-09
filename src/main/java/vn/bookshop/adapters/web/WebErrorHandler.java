package vn.bookshop.adapters.web;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.*;
/** Delivery error mapping; database internals are never returned to the browser. */
@ControllerAdvice
public class WebErrorHandler {
 /** Missing transport fields do not reach a use case and cause no writes. */
 @ExceptionHandler(MissingServletRequestParameterException.class)
 public String badInput(Model model,HttpServletResponse response){response.setStatus(400);model.addAttribute("status",400);model.addAttribute("message","Yêu cầu thiếu dữ liệu. Hãy tải lại trang.");return "problem";}
 /** Read failures surface as 503; no claim that an uncertain write did or did not commit. */
 @ExceptionHandler(DataAccessException.class)
 public String unavailable(Model model,HttpServletResponse response){response.setStatus(503);model.addAttribute("status",503);model.addAttribute("message","Chưa thể tải dữ liệu. Vui lòng thử lại.");return "problem";}
}
