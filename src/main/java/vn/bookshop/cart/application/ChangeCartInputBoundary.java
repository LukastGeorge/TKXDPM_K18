package vn.bookshop.cart.application;
/** Application entry point for S1-D01..06. */
public interface ChangeCartInputBoundary {
    /**
     * Validates owner/version/quantity/SKU/availability, quotes backend prices and saves atomically.
     * Calls output once. Invalid input/stock/ownership leaves persisted cart and inventory unchanged.
     * Example SET S001=0 removes S001 only; ADD1 to existing2 results3 if availability>=3.
     */
    void execute(ChangeCartRequest request);
}
