/* Kolom product_id adalah Primary Key dari dataset product
dan merupakan Foreign Key untuk dataset order_item */
ALTER TABLE products ADD CONSTRAINT pk_products PRIMARY KEY (product_id);
ALTER TABLE order_item ADD FOREIGN KEY (product_id) REFERENCES products;

/* Primary Key untuk table lainnya */
ALTER TABLE customers ADD CONSTRAINT pk_cust PRIMARY KEY (customer_id);
-- ALTER TABLE geolocation ADD CONSTRAINT pk_geo PRIMARY KEY (geo_zip_code_prefix);
ALTER TABLE orders ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);
ALTER TABLE sellers ADD CONSTRAINT pk_seller PRIMARY KEY (seller_id);

/* Foreign Key untuk hubungan antar table lainnya */
-- ALTER TABLE customers ADD FOREIGN KEY (customer_zip_code_prefix) REFERENCES geolocation;
-- ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers;
ALTER TABLE order_item ADD FOREIGN KEY (order_id) REFERENCES orders;
ALTER TABLE order_item ADD FOREIGN KEY (seller_id) REFERENCES sellers;
-- ALTER TABLE sellers ADD FOREIGN KEY (seller_zip_code_prefix) REFERENCES geolocation;
ALTER TABLE payments ADD FOREIGN KEY (order_id) REFERENCES orders;
ALTER TABLE reviews ADD FOREIGN KEY (order_id) REFERENCES orders;