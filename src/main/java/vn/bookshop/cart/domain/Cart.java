package vn.bookshop.cart.domain;

import java.util.Map;
import java.util.LinkedHashMap;
import java.util.UUID;

/** Immutable guest cart. Lines hold positive integer units; no price or stock commitment. */
public final class Cart {
    private final UUID id;
    private final String owner;
    private final long version;
    private final Map<String,Integer> lines;
    /** Creates a defensive snapshot; rejects null/blank IDs, negative version or nonpositive lines. */
    public Cart(UUID id, String owner, long version, Map<String, Integer> lines) {
        if(id==null || owner==null || owner.isBlank() || version<0 || lines==null)
            throw new IllegalArgumentException("Invalid cart snapshot");
        lines.forEach((sku,quantity)->{
            if(sku==null || sku.isBlank() || quantity==null || quantity<=0)
                throw new IllegalArgumentException("Invalid cart line");
        });
        this.id=id;this.owner=owner;this.version=version;this.lines=Map.copyOf(lines);
    }
    /** Stable cart identifier; no side effects. */
    public UUID id() { return id; }
    /** Server-authenticated owner reference; never exposed in a view model. */
    public String owner() { return owner; }
    /** Nonnegative optimistic version read from persistence. */
    public long version() { return version; }
    /** Returns an unmodifiable SKU/quantity snapshot. */
    public Map<String,Integer> lines() { return lines; }
    /** Returns units of this SKU, or 0 for an absent line. */
    public int quantity(String sku) { return lines.getOrDefault(sku,0); }
    /**
     * Returns a changed copy with the same version. Quantity 0 removes only this SKU.
     * @param sku nonblank stable book edition identifier
     * @param quantity integer units, at least zero
     * @return immutable new cart; this instance and inventory are unchanged
     * @throws IllegalArgumentException for blank SKU or negative quantity
     */
    public Cart changeLine(String sku,int quantity) {
        if(sku==null || sku.isBlank() || quantity<0)throw new IllegalArgumentException("Invalid line change");
        Map<String,Integer> changed=new LinkedHashMap<>(lines);
        if(quantity==0)changed.remove(sku);else changed.put(sku,quantity);
        return new Cart(id,owner,version,changed);
    }
    /** Returns a copy with a persisted nonnegative version; lines/owner are unchanged. */
    public Cart withVersion(long version) { return new Cart(id,owner,version,lines); }
}
