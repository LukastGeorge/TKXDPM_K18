package vn.bookshop.adapters.web;
import vn.bookshop.cart.application.*;
/** Request-scoped output adapter; retains one response for HTTP rendering, never application logic. */
public class CartPresenter implements ChangeCartOutputBoundary {
 private ChangeCartResponse response;
 /** Stores a nonnull use-case response for this request only. */
 @Override public void present(ChangeCartResponse response){this.response=java.util.Objects.requireNonNull(response);}
 /** Requires a completed use-case call; fails if the wiring forgot to execute it. */
 public ChangeCartResponse response(){if(response==null)throw new IllegalStateException("Use case not executed");return response;}
}
