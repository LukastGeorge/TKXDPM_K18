package vn.bookshop.cart.application;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
/** Public cart data contains no owner/session secret; current prices, not a checkout promise. */
public record CartSnapshot(UUID id,long version,List<CartLineSnapshot> lines,BigDecimal totalVnd) {
    /** Defensively copies the line collection; line records are immutable. */
    public CartSnapshot { lines=List.copyOf(lines); }
}
