package vn.bookshop.catalog.application;
import java.util.List;
import java.util.Optional;
import vn.bookshop.catalog.domain.Book;
/** Application-owned read contract. Implementations return backend prices/stock, never client totals. */
public interface CatalogReadPort {
    /** Returns visible editions ordered by SKU; empty list is valid; no writes. */
    List<Book> listVisible();
    /** Looks up an edition including hidden ones for existing-cart display/removal; absent is empty. */
    Optional<Book> find(String sku);
}
