package vn.bookshop.cart.application;
import java.util.Objects;
/** Separate read/open policy; does not masquerade as a change command. */
public final class CartQueryInteractor implements CartQueryInputBoundary {
    private final CartPort carts;private final PricingService prices;private final ChangeCartOutputBoundary output;
    public CartQueryInteractor(CartPort carts,PricingService prices,ChangeCartOutputBoundary output) {
        this.carts=Objects.requireNonNull(carts);this.prices=Objects.requireNonNull(prices);this.output=Objects.requireNonNull(output);
    }
    /** {@inheritDoc} */
    @Override public void execute(CartQueryRequest request){
        ChangeCartResponse response;
        if(request==null || request.owner()==null || request.owner().isBlank())response=new ChangeCartResponse(CartStatus.INVALID_INPUT,"Phiên truy cập không hợp lệ",null);
        else try{response=new ChangeCartResponse(CartStatus.OK,"",prices.quote(carts.open(request.owner())));}
        catch(RuntimeException e){response=new ChangeCartResponse(CartStatus.UNAVAILABLE,"Chưa đọc được giỏ; vui lòng thử lại",null);}
        output.present(response);
    }
}
