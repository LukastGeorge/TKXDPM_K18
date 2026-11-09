package vn.bookshop.delivery;
import org.springframework.context.annotation.*;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import vn.bookshop.catalog.application.*;
import vn.bookshop.cart.application.*;
import vn.bookshop.adapters.web.*;
import vn.bookshop.infrastructure.persistence.*;
/** Owns concrete construction. Core depends only on its own ports. */
@Configuration
public class CompositionRoot {
 /** Shares Spring's transaction manager and DataSource for atomic JDBC writes. */
 @Bean CartPort cartPort(JdbcTemplate jdbc,PlatformTransactionManager manager){return new PostgresCartAdapter(jdbc,new TransactionTemplate(manager));}
 /** Reads the configured catalog database through the core-owned port. */
 @Bean CatalogReadPort catalogPort(JdbcTemplate jdbc){return new PostgresCatalogAdapter(jdbc);}
 /** Prices only the regular-price S1 catalog, no fees or promotion rules. */
 @Bean PricingService prices(CatalogReadPort catalog){return new PricingService(catalog);}
 /** A fresh output buffer for each HTTP request avoids cross-user response leakage. */
 @Bean @RequestScope CartPresenter cartPresenter(){return new CartPresenter();}
 /** A fresh output buffer for each HTTP request. */
 @Bean @RequestScope CatalogPresenter catalogPresenter(){return new CatalogPresenter();}
 /** Wires catalog input to its request-scoped output. */
 @Bean CatalogInputBoundary catalogInput(CatalogReadPort port,CatalogPresenter out){return new CatalogInteractor(port,out);}
 /** Wires read-or-create cart input to the request-scoped output. */
 @Bean CartQueryInputBoundary cartQuery(CartPort port,PricingService prices,CartPresenter out){return new CartQueryInteractor(port,prices,out);}
 /** Wires the cart mutation policy to storage/read ports and output. */
 @Bean ChangeCartInputBoundary cartChange(CartPort port,CatalogReadPort catalog,PricingService prices,CartPresenter out){return new ChangeCartInteractor(port,catalog,prices,out);}
 /** Permits guest endpoints while retaining Spring's CSRF protection and security headers. */
 @Bean SecurityFilterChain security(HttpSecurity http)throws Exception{return http.authorizeHttpRequests(a->a.anyRequest().permitAll()).build();}
}
