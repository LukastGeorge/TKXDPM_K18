package vn.bookshop.delivery;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration;
/** Delivery entry point. S1 is public guest browsing; no account authentication yet. */
@SpringBootApplication(scanBasePackages="vn.bookshop",exclude=UserDetailsServiceAutoConfiguration.class)
public class BookshopApplication {
 /** Starts HTTP delivery with external database configuration; startup fails if migration cannot run. */
 public static void main(String[] args){SpringApplication.run(BookshopApplication.class,args);}
}
