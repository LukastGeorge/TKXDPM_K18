package vn.bookshop.catalog.domain;
import java.math.BigDecimal;
/** Edition data read from a trusted catalog: whole VND, H>=R>=0; fixture data is not an order snapshot. */
public record Book(String sku,String title,String author,String publisher,String category,
        String description,String coverPath,BigDecimal priceVnd,int onHand,int reserved,boolean visible) {
    /** Available units H-R; reading does not reserve inventory. */
    public int available(){return onHand-reserved;}
}
