package vn.bookshop.cart.application;
import java.util.Optional;
import java.util.UUID;
import vn.bookshop.cart.domain.Cart;
/** Atomic persistence contract owned by the cart use cases. Storage failures propagate, never success. */
public interface CartPort {
    /** Loads/creates exactly one empty guest cart per nonblank server owner; inventory unchanged. */
    Cart open(String owner);
    /** Returns empty for missing OR foreign cart; must not expose another owner's content. */
    Optional<Cart> loadOwned(UUID id,String owner);
    /**
     * Atomically replaces lines and increments persisted version once when id/owner/version match.
     * False means stale/missing owner, with no writes. Exceptions must roll back ALL changes.
     * Does not change stock. Cart and expectedVersion must describe the same read version.
     */
    boolean save(Cart cart,long expectedVersion);
}
