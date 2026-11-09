package vn.bookshop.support;
import java.util.*;
import vn.bookshop.cart.application.CartPort;
import vn.bookshop.cart.domain.Cart;
import vn.bookshop.catalog.application.CatalogReadPort;
import vn.bookshop.catalog.domain.Book;
/** Test-only fake; has contract semantics but does NOT demonstrate PostgreSQL isolation or rollback. */
public final class MemoryStore implements CartPort,CatalogReadPort {
    public final Map<String,Book> books=new HashMap<>();
    public final Map<UUID,Cart> carts=new HashMap<>();
    public boolean rejectSave;
    public int saves;
    @Override public List<Book> listVisible(){return books.values().stream().filter(Book::visible).sorted(Comparator.comparing(Book::sku)).toList();}
    @Override public Optional<Book> find(String sku){return Optional.ofNullable(books.get(sku));}
    @Override public synchronized Cart open(String owner){
        return carts.values().stream().filter(c->c.owner().equals(owner)).findFirst().orElseGet(()->{
            Cart c=new Cart(UUID.randomUUID(),owner,0,Map.of());carts.put(c.id(),c);return c;});
    }
    @Override public synchronized Optional<Cart> loadOwned(UUID id,String owner){return Optional.ofNullable(carts.get(id)).filter(c->c.owner().equals(owner));}
    @Override public synchronized boolean save(Cart cart,long expected){
        if(cart.version()!=expected)throw new IllegalArgumentException("cart/read version mismatch");
        Cart old=carts.get(cart.id());
        if(rejectSave || old==null || !old.owner().equals(cart.owner()) || old.version()!=expected)return false;
        carts.put(cart.id(),cart.withVersion(expected+1));saves++;return true;
    }
}
