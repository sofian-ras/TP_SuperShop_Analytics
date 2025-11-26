DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE categories (
    id_cat SERIAL PRIMARY KEY,
    name_cat VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE products (
    id_prod SERIAL PRIMARY KEY,
    name_prod VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    id_cat INT NOT NULL,
    CONSTRAINT fk_categories FOREIGN KEY (id_cat) REFERENCES categories(id_cat)
);

CREATE TABLE customers (
    id_customer SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id_order SERIAL PRIMARY KEY,
    id_customer INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) NOT NULL CHECK (status IN ('PENDING','PAID','SHIPPED','CANCELLED')),
    CONSTRAINT fk_customers FOREIGN KEY (id_customer) REFERENCES customers(id_customer)
);

CREATE TABLE order_items (
    id_item SERIAL PRIMARY KEY,
    id_order INT NOT NULL,
    id_prod INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT fk_orders FOREIGN KEY (id_order) REFERENCES orders(id_order),
    CONSTRAINT fk_products FOREIGN KEY (id_prod) REFERENCES products(id_prod)
);