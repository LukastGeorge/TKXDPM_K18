package vn.bookshop.infrastructure.persistence;
import java.util.List;
import java.util.Optional;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vn.bookshop.catalog.application.CatalogReadPort;
import vn.bookshop.catalog.domain.Book;
/** SQL read adapter; no catalog mutation. Implements the application's read contract. */
public final class PostgresCatalogAdapter implements CatalogReadPort {
 private final JdbcTemplate jdbc;
 private static final RowMapper<Book> ROW=(rs,n)->new Book(rs.getString("sku"),rs.getString("title"),rs.getString("author"),rs.getString("publisher"),rs.getString("category"),rs.getString("description"),rs.getString("cover_path"),rs.getBigDecimal("price_vnd"),rs.getInt("on_hand"),rs.getInt("reserved"),rs.getBoolean("visible"));
 /** Requires a configured JDBC connection source; does not execute SQL during construction. */
 public PostgresCatalogAdapter(JdbcTemplate jdbc){this.jdbc=java.util.Objects.requireNonNull(jdbc);}
 @Override public List<Book> listVisible(){return jdbc.query("SELECT * FROM books WHERE visible=true ORDER BY sku",ROW);}
 @Override public Optional<Book> find(String sku){return jdbc.query("SELECT * FROM books WHERE sku=?",ROW,sku).stream().findFirst();}
}
