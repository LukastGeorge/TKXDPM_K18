package vn.bookshop.cart.application;
/** Stable use-case outcomes independent of HTTP. */
public enum CartStatus { OK, INVALID_INPUT, NOT_FOUND, FORBIDDEN, CONFLICT, OUT_OF_STOCK, EXCEEDS_STOCK, UNAVAILABLE }
