package vn.bookshop.cart.application;
import java.util.UUID;
/** Primitive use-case input. Owner comes from server session; quantity text is validated by the use case. */
public record ChangeCartRequest(UUID cartId,String owner,String sku,String quantity,long expectedVersion,ChangeMode mode) {}
