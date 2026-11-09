package vn.bookshop.cart.application;
/** Server-derived guest owner, not a client-selected account. */
public record CartQueryRequest(String owner) {}
