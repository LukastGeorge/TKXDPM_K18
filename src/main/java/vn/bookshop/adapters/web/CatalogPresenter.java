package vn.bookshop.adapters.web;
import vn.bookshop.catalog.application.*;
/** Request-scoped catalog output adapter. */
public class CatalogPresenter implements CatalogOutputBoundary {
 private CatalogResponse response;
 /** Retains the nonnull response for the current request. */
 @Override public void present(CatalogResponse response){this.response=java.util.Objects.requireNonNull(response);}
 /** Returns the response after execution; never silently manufactures data. */
 public CatalogResponse response(){if(response==null)throw new IllegalStateException("Use case not executed");return response;}
}
