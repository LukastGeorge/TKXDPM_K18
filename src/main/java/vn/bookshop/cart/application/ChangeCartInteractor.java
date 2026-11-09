package vn.bookshop.cart.application;
import vn.bookshop.catalog.application.CatalogReadPort;
import java.util.Objects;
/** S1 orchestration. Owns neither SQL nor concrete presenter. */
public final class ChangeCartInteractor implements ChangeCartInputBoundary {
    private final CartPort carts;
    private final CatalogReadPort catalog;
    private final PricingService prices;
    private final ChangeCartOutputBoundary output;
    /** Dependencies are supplied from the composition root. */
    public ChangeCartInteractor(CartPort carts,CatalogReadPort catalog,PricingService prices,ChangeCartOutputBoundary output) {
        this.carts=Objects.requireNonNull(carts);this.catalog=Objects.requireNonNull(catalog);
        this.prices=Objects.requireNonNull(prices);this.output=Objects.requireNonNull(output);
    }
    /** {@inheritDoc} */
    @Override public void execute(ChangeCartRequest request){
        ChangeCartResponse response;
        try{response=change(request);}
        catch(RuntimeException storageFailure){response=error(CartStatus.UNAVAILABLE,"Không thể xác nhận lưu giỏ; hãy tải lại giỏ trước khi thử tiếp.");}
        output.present(response);
    }
    /** Checks command and stages one immutable change before a single atomic persistence call. */
    private ChangeCartResponse change(ChangeCartRequest r){
        if(r==null || r.cartId()==null || r.owner()==null || r.owner().isBlank() || r.sku()==null || r.sku().isBlank() || r.mode()==null || r.expectedVersion()<0)
            return error(CartStatus.INVALID_INPUT,"Yêu cầu giỏ hàng không hợp lệ");
        var found=carts.loadOwned(r.cartId(),r.owner());
        if(found.isEmpty())return error(CartStatus.FORBIDDEN,"Không có quyền truy cập giỏ hàng này");
        var cart=found.get();
        if(cart.version()!=r.expectedVersion())return error(CartStatus.CONFLICT,"Giỏ đã thay đổi; hãy tải lại trước khi sửa");
        String raw=r.quantity()==null?"":r.quantity().trim();
        if(raw.isEmpty())return error(CartStatus.INVALID_INPUT,"Số lượng không được để trống");
        if(!raw.matches("-?[0-9]+"))return error(CartStatus.INVALID_INPUT,"Số lượng phải là số nguyên");
        int amount;
        try{amount=Integer.parseInt(raw);}catch(NumberFormatException e){return error(CartStatus.INVALID_INPUT,"Số lượng quá lớn");}
        if(amount<0)return error(CartStatus.INVALID_INPUT,"Số lượng không được âm");
        if(r.mode()==ChangeMode.ADD && amount==0)return error(CartStatus.INVALID_INPUT,"Số lượng thêm phải lớn hơn 0");
        long quantity=r.mode()==ChangeMode.ADD?(long)cart.quantity(r.sku())+amount:amount;
        if(quantity>0){
            var edition=catalog.find(r.sku()).filter(b->b.visible());
            if(edition.isEmpty())return error(CartStatus.NOT_FOUND,"Không tìm thấy sách đang bán");
            int available=edition.get().available();
            if(available==0)return error(CartStatus.OUT_OF_STOCK,"Sách hết hàng");
            if(quantity>available)return error(CartStatus.EXCEEDS_STOCK,"Số lượng vượt tồn kho khả dụng "+available);
        }else if(cart.quantity(r.sku())==0){
            return error(CartStatus.NOT_FOUND,"Không tìm thấy dòng sách trong giỏ");
        }
        var changed=cart.changeLine(r.sku(),(int)quantity);
        var snapshot=prices.quote(changed.withVersion(r.expectedVersion()+1));
        if(!carts.save(changed,r.expectedVersion()))return error(CartStatus.CONFLICT,"Giỏ đã thay đổi; hãy tải lại trước khi sửa");
        return new ChangeCartResponse(CartStatus.OK,"Đã cập nhật giỏ hàng",snapshot);
    }
    /** Creates a safe error without a cart payload or side effects. */
    private static ChangeCartResponse error(CartStatus status,String message){return new ChangeCartResponse(status,message,null);}
}
