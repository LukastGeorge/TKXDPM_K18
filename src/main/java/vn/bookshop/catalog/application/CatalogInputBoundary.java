package vn.bookshop.catalog.application;
public interface CatalogInputBoundary {
    /** Returns visible list/detail via output exactly once; empty list is valid, unknown detail is not found. */
    void execute(CatalogRequest request);
}
