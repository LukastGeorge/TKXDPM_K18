package vn.bookshop.catalog.application;
import java.util.List;
import vn.bookshop.catalog.domain.Book;
/** Public catalog response, no identity data; missing detail returns found=false. */
public record CatalogResponse(boolean found,List<Book> books,Book selected,String message) {
    public CatalogResponse {books=List.copyOf(books);}
}
