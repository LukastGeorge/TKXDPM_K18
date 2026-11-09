package vn.bookshop.cart.application;
/** Output contract owned by application, implemented by presentation/delivery. */
@FunctionalInterface
public interface ChangeCartOutputBoundary {
    /** Receives exactly one safe response per completed use-case call; never performs business writes. */
    void present(ChangeCartResponse response);
}
