package vn.bookshop.catalog.application;
import java.util.List;
import java.util.Objects;
public final class CatalogInteractor implements CatalogInputBoundary {
    private final CatalogReadPort catalog;private final CatalogOutputBoundary output;
    public CatalogInteractor(CatalogReadPort catalog,CatalogOutputBoundary output) {this.catalog=Objects.requireNonNull(catalog);this.output=Objects.requireNonNull(output);}
    /** {@inheritDoc} */
    @Override public void execute(CatalogRequest request){
        if(request.sku()==null){output.present(new CatalogResponse(true,catalog.listVisible(),null,""));return;}
        var book=catalog.find(request.sku()).filter(b->b.visible());
        output.present(book.map(b->new CatalogResponse(true,List.of(),b,""))
            .orElseGet(()->new CatalogResponse(false,List.of(),null,"Không tìm thấy sách")));
    }
}
