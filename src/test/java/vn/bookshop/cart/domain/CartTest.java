package vn.bookshop.cart.domain;

import org.junit.jupiter.api.Test;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import static org.junit.jupiter.api.Assertions.*;

class CartTest {
    private final UUID id=UUID.randomUUID();
    @Test void zeroRemovesOnlySelectedLineWithoutMutatingOriginal() {
        Cart before=new Cart(id,"guest-A",3,Map.of("S001",2,"S002",1));
        Cart after=before.changeLine("S001",0);
        assertEquals(Map.of("S002",1),after.lines());
        assertEquals(Map.of("S001",2,"S002",1),before.lines());
        assertEquals(3,after.version());
    }
    @Test void settingQuantityIsAbsoluteAndLastRemovalProducesEmptyCart() {
        Cart cart=new Cart(id,"guest-A",0,Map.of("S001",2));
        assertEquals(3,cart.changeLine("S001",3).quantity("S001"));
        assertTrue(cart.changeLine("S001",0).lines().isEmpty());
    }
    @Test void rejectsInvalidChangeWithoutAlteringState() {
        Cart cart=new Cart(id,"guest-A",0,Map.of("S001",2));
        assertThrows(IllegalArgumentException.class,()->cart.changeLine("S001",-1));
        assertThrows(IllegalArgumentException.class,()->cart.changeLine(" ",1));
        assertEquals(2,cart.quantity("S001"));
    }
    @Test void protectsMapAtConstructionAndAtReadBoundary() {
        Map<String,Integer> input=new HashMap<>();input.put("S001",1);
        Cart cart=new Cart(id,"guest-A",0,input);input.put("S001",99);
        assertEquals(1,cart.quantity("S001"));
        assertThrows(UnsupportedOperationException.class,()->cart.lines().put("S002",1));
    }
    @Test void rejectsInvalidSnapshots() {
        assertThrows(IllegalArgumentException.class,()->new Cart(id,"",0,Map.of()));
        assertThrows(IllegalArgumentException.class,()->new Cart(id,"A",-1,Map.of()));
        assertThrows(IllegalArgumentException.class,()->new Cart(id,"A",0,Map.of("S001",0)));
    }
}
