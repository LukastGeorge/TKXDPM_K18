package vn.bookshop.integration;
import java.util.UUID;
import org.flywaydb.core.Flyway;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;
/** Dedicated disposable schema; never clear the application/public schema. */
final class DatabaseFixture implements AutoCloseable {
 final String schema="test_s1_"+UUID.randomUUID().toString().replace("-","");
 final String user=System.getenv().getOrDefault("BOOK_DB_USER","bookshop");
 final String password=System.getenv("BOOK_DB_PASSWORD");
 final String base=System.getenv().getOrDefault("BOOK_DB_URL","jdbc:postgresql://127.0.0.1:55432/bookshop");
 final String url=base+(base.contains("?")?"&":"?")+"currentSchema="+schema;
 final JdbcTemplate admin,jdbc;final TransactionTemplate tx;
 DatabaseFixture(){
  if(password==null||password.isBlank())throw new IllegalStateException("BOOK_DB_PASSWORD required; start scripts/Start-Database.ps1 and load .env");
  admin=new JdbcTemplate(new DriverManagerDataSource(base,user,password));
  admin.execute("CREATE SCHEMA "+schema);
  var ds=new DriverManagerDataSource(url,user,password);jdbc=new JdbcTemplate(ds);tx=new TransactionTemplate(new DataSourceTransactionManager(ds));
  Flyway.configure().dataSource(ds).defaultSchema(schema).locations("classpath:db/migration").load().migrate();
 }
 public void close(){if(!schema.matches("test_s1_[a-f0-9]{32}"))throw new IllegalStateException("Unsafe schema");admin.execute("DROP SCHEMA "+schema+" CASCADE");}
}
