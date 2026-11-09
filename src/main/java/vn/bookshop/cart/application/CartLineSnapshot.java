package vn.bookshop.cart.application;
import java.math.BigDecimal;
/** Public read-only line; quantity in units, prices in whole VND, backend sourced. */
public record CartLineSnapshot(String sku,String title,int quantity,BigDecimal unitPriceVnd,
        BigDecimal totalVnd,int available,boolean sellable) {}
