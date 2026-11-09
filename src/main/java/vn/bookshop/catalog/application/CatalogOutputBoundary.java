package vn.bookshop.catalog.application;
@FunctionalInterface
public interface CatalogOutputBoundary {
    /** Formats a public response without modifying catalog. */
    void present(CatalogResponse response);
}
