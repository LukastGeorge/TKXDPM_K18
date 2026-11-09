package vn.bookshop.catalog.application;
/** Null SKU requests the catalog; nonnull SKU requests a single visible edition. */
public record CatalogRequest(String sku) {}
