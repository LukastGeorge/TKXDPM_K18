package vn.bookshop.cart.application;
/** Read/open cart use-case contract. */
public interface CartQueryInputBoundary {
    /** Opens the owner's cart and quotes current backend prices through the output port; no stock writes. */
    void execute(CartQueryRequest request);
}
