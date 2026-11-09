package vn.bookshop.cart.application;
import vn.bookshop.catalog.application.CatalogReadPort;
import vn.bookshop.cart.domain.Cart;
import java.math.BigDecimal;
import java.util.Comparator;
import java.util.Objects;
/** S1 regular-price quotation only; special offers remain out of this slice. */
public final class PricingService {
    private final CatalogReadPort catalog;
    public PricingService(CatalogReadPort catalog) {this.catalog=Objects.requireNonNull(catalog);}
    /** Reads current catalog prices, multiplies whole VND exactly, returns total; no writes/reservations. */
    public CartSnapshot quote(Cart cart){
        var lines=cart.lines().entrySet().stream().sorted(Comparator.comparing(e->e.getKey())).map(e->{
            var book=catalog.find(e.getKey()).orElseThrow(()->new IllegalStateException("Cart edition missing"));
            return new CartLineSnapshot(book.sku(),book.title(),e.getValue(),book.priceVnd(),
                book.priceVnd().multiply(BigDecimal.valueOf(e.getValue())),book.available(),book.visible());
        }).toList();
        var total=lines.stream().map(CartLineSnapshot::totalVnd).reduce(BigDecimal.ZERO,BigDecimal::add);
        return new CartSnapshot(cart.id(),cart.version(),lines,total);
    }
}
