package vn.bookshop.infrastructure.persistence;
import java.util.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.support.TransactionTemplate;
import vn.bookshop.cart.application.CartPort;
import vn.bookshop.cart.domain.Cart;
/** Single-database atomic cart aggregate. SQL errors propagate after rollback. */
public final class PostgresCartAdapter implements CartPort {
 private final JdbcTemplate jdbc;private final TransactionTemplate tx;
 /** Both dependencies must refer to the same DataSource for atomic writes. */
 public PostgresCartAdapter(JdbcTemplate jdbc,TransactionTemplate tx){this.jdbc=Objects.requireNonNull(jdbc);this.tx=Objects.requireNonNull(tx);}
 @Override public Cart open(String owner){
  if(owner==null||owner.isBlank())throw new IllegalArgumentException("owner required");
  return tx.execute(status->{jdbc.update("INSERT INTO carts(id,owner,version) VALUES (?,?,0) ON CONFLICT(owner) DO NOTHING",UUID.randomUUID(),owner);
   UUID id=jdbc.queryForObject("SELECT id FROM carts WHERE owner=?",UUID.class,owner);return read(id,owner).orElseThrow();});
 }
 @Override public Optional<Cart> loadOwned(UUID id,String owner){return tx.execute(status->read(id,owner));}
 /** Locks the aggregate row until all lines are read, preventing mixed-version snapshots. */
 private Optional<Cart> read(UUID id,String owner){
  var versions=jdbc.query("SELECT version FROM carts WHERE id=? AND owner=? FOR SHARE",(rs,n)->rs.getLong(1),id,owner);
  if(versions.isEmpty())return Optional.empty();
  Map<String,Integer> lines=new LinkedHashMap<>();jdbc.query("SELECT sku,quantity FROM cart_lines WHERE cart_id=? ORDER BY sku",rs->{lines.put(rs.getString(1),rs.getInt(2));},id);
  return Optional.of(new Cart(id,owner,versions.getFirst(),lines));
 }
 @Override public boolean save(Cart cart,long expectedVersion){
  if(cart.version()!=expectedVersion)throw new IllegalArgumentException("cart/read version mismatch");
  return Boolean.TRUE.equals(tx.execute(status->{
   int updated=jdbc.update("UPDATE carts SET version=version+1 WHERE id=? AND owner=? AND version=?",cart.id(),cart.owner(),expectedVersion);
   if(updated==0)return false;
   jdbc.update("DELETE FROM cart_lines WHERE cart_id=?",cart.id());
   cart.lines().forEach((sku,quantity)->jdbc.update("INSERT INTO cart_lines(cart_id,sku,quantity) VALUES (?,?,?)",cart.id(),sku,quantity));
   return true;
  }));
 }
}
