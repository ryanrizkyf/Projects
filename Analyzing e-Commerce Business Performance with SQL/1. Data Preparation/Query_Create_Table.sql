/* Query Create Table */

CREATE TABLE customers (
	customer_id varchar(250),
	customer_unique_id varchar(250),
	customer_zip_code_prefix int,
	customer_city varchar(250),
	customer_state varchar(250)
);

CREATE TABLE geolocation (
	geo_zip_code_prefix varchar(250),
	geo_lat varchar(250),
	geo_lng varchar(250),
	geo_city varchar(250),
	geo_state varchar(250)
);

CREATE TABLE order_item (
	order_id varchar(250),
	order_item_id int,
	product_id varchar(250),
	seller_id varchar(250),
	shipping_limit_date timestamp,
	price float,
	freight_value float
);

CREATE TABLE payments (
	order_id varchar(250),
	payment_sequential int,
	payment_type varchar(250),
	payment_installment int,
	payment_value float
);

CREATE TABLE reviews (
	review_id varchar(250),
	order_id varchar(250),
	review_score int,
	review_comment_title varchar(250),
	review_comment_message text,
	review_creation_date timestamp,
	review_answer timestamp
);

CREATE TABLE orders (
	order_id varchar(250),
	customers_id varchar(250),
	order_status varchar(250),
	order_purchase_timestamp timestamp,
	order_approved_at timestamp,
	order_delivered_carrier_date timestamp,
	order_delivered_customer_date timestamp,
	order_estimated_delivered_date timestamp
);

CREATE TABLE products (
	no int,
	product_id varchar(250),
	product_category_name varchar(250),
	product_name_length int,
	product_description_length int,
	product_photos_qty int,
	product_weight_g int,
	product_length_cm int,
	product_height_cm int,
	product_width_cm int
);

CREATE TABLE sellers (
	seller_id varchar(250),
	seller_zip_code int,
	seller_city varchar(250),
	seller_state varchar(250)
);