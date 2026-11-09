CREATE TABLE books (
 sku varchar(80) PRIMARY KEY, title text NOT NULL, author text NOT NULL,
 publisher text NOT NULL, category text NOT NULL, description text NOT NULL,
 cover_path text NOT NULL, price_vnd numeric(19,0) NOT NULL CHECK(price_vnd >= 0),
 on_hand integer NOT NULL CHECK(on_hand >= 0), reserved integer NOT NULL CHECK(reserved >= 0),
 visible boolean NOT NULL DEFAULT true, CHECK(reserved <= on_hand)
);
CREATE TABLE carts (
 id uuid PRIMARY KEY, owner varchar(200) UNIQUE NOT NULL CHECK(length(owner)>0),
 version bigint NOT NULL DEFAULT 0 CHECK(version >= 0)
);
CREATE TABLE cart_lines (
 cart_id uuid NOT NULL REFERENCES carts(id) ON DELETE CASCADE,
 sku varchar(80) NOT NULL REFERENCES books(sku),
 quantity integer NOT NULL CHECK(quantity > 0), PRIMARY KEY(cart_id,sku)
);
