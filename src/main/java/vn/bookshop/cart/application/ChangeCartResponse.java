package vn.bookshop.cart.application;
/** Success has a snapshot; errors can omit it, especially foreign-cart errors. Message is safe for display. */
public record ChangeCartResponse(CartStatus status,String message,CartSnapshot cart) {}
