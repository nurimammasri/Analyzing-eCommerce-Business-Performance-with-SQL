--	====================== Analyzing eCommerce Business Performance with SQL ====================== 

--	Created by: 
--	Nur Imam Masri
--	Email : nurimammasri.01@gmail.com
--	LinkedIn : linkedin.com/in/nurimammasri
--	Github : github.com/nurimammasri
--	Portfolio : bit.ly/ImamProjectPortfolio 

--  -----------------------------------------------------------------------------------------

--	Data Preparation

--	Preparing raw data into structured data and ready to be processed. 
--	We have to enter data in csv format into database tables using 
--	PostgreSQL. Then create an entity relationship between these tables.

-- =============== 1. CREATE DATABASE =============== 

-- CREATE DATABASE ecommerce;


-- =============== 2. CREATE TABLE =============== 

-- ======= product ======= 

CREATE TABLE products (
	column1 int4 NULL,
	product_id varchar(50) NOT NULL,
	product_category_name varchar(50) NULL,
	product_name_lenght float8 NULL,
	product_description_lenght float8 NULL,
	product_photos_qty float8 NULL,
	product_weight_g float8 NULL,
	product_length_cm float8 NULL,
	product_height_cm float8 NULL,
	product_width_cm float8 NULL,
	CONSTRAINT products_pk PRIMARY KEY (product_id)
);

-- ======= order_payment ======= 

CREATE TABLE order_payments (
	order_id varchar(50) NULL,
	payment_sequential int4 NULL,
	payment_type varchar(50) NULL,
	payment_installments int4 NULL,
	payment_value float8 NULL
);

-- ======= order_reviews ======= 

CREATE TABLE order_reviews (
	review_id varchar(100) NULL,
	order_id varchar(100) NULL,
	review_score int4 NULL,
	review_comment_title varchar(100) NULL,
	review_comment_message varchar(400) NULL,
	review_creation_date timestamp NULL,
	review_answer_timestamp timestamp NULL
);

-- ======= orders ======= 

CREATE TABLE orders (
	order_id varchar(50) NOT NULL,
	customer_id varchar(50) NULL,
	order_status varchar(50) NULL,
	order_purchase_timestamp timestamp NULL,
	order_approved_at timestamp NULL,
	order_delivered_carrier_date timestamp NULL,
	order_delivered_customer_date timestamp NULL,
	order_estimated_delivery_date timestamp NULL,
	CONSTRAINT orders_pk PRIMARY KEY (order_id)
);

-- ======= customers ======= 

CREATE TABLE customers (
	customer_id varchar(50) NOT NULL,
	customer_unique_id varchar(50) NULL,
	customer_zip_code_prefix varchar(50) NULL,
	customer_city varchar(50) NULL,
	customer_state varchar(50) NULL,
	CONSTRAINT customers_pk PRIMARY KEY (customer_id)
);

-- ======= geolocation (dirty) ======= 

CREATE TABLE geolocation_dirty (
	geolocation_zip_code_prefix varchar(50) NULL,
	geolocation_lat float8 NULL,
	geolocation_lng float8 NULL,
	geolocation_city varchar(50) NULL,
	geolocation_state varchar(50) NULL
);

-- ======= seller ======= 

CREATE TABLE sellers (
	seller_id varchar(50) NOT NULL,
	seller_zip_code_prefix varchar(50) NULL,
	seller_city varchar(50) NULL,
	seller_state varchar(50) NULL,
	CONSTRAINT sellers_pk PRIMARY KEY (seller_id)
);

-- ======= order_items ======= 

CREATE TABLE order_items (
	order_id varchar(50) NULL,
	order_item_id int4 NULL,
	product_id varchar(50) NULL,
	seller_id varchar(50) NULL,
	shipping_limit_date timestamp NULL,
	price float8 NULL,
	freight_value float8 NULL
);




-- =============== 2. Import Datasets =============== 

-- ======= product ======= 

COPY products(
	column1,
	product_id,
	product_category_name,
	product_name_lenght,
	product_description_lenght,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm
)
FROM
'\Dataset\product_dataset.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE products DROP COLUMN column1;

-- ======= order_payment ======= 

COPY order_payments(
	order_id,
	payment_sequential,
	payment_type,
	payment_installments,
	payment_value
)
FROM
'\Dataset\order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= order_reviews ======= 

COPY order_reviews(
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp
)
FROM
'\Dataset\order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= orders ======= 

COPY orders(
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
)
FROM
'\Dataset\orders_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= customers ======= 

COPY customers(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
)
FROM
'\Dataset\customers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= seller ======= 

COPY sellers(
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
)
FROM
'\Dataset\sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= order_items ======= 

COPY order_items(
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value
)
FROM
'\Dataset\order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= geolocation (dirty) ======= 

COPY geolocation_dirty(
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng,
	geolocation_city,
	geolocation_state
)
FROM
'\Dataset\geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ======= geolocation (clean) ======= 

--	select string_agg(c,'')
--	from (
--	  select distinct regexp_split_to_table(lower(geolocation_city),'') as c
--	  from geolocation g 
--	) t

-- create geolocation clean

CREATE TABLE geolocation_dirty2 AS
SELECT geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, 
REPLACE(REPLACE(REPLACE(
TRANSLATE(TRANSLATE(TRANSLATE(TRANSLATE(
TRANSLATE(TRANSLATE(TRANSLATE(TRANSLATE(
    geolocation_city, '£,³,´,.', ''), '`', ''''), 
    'é,ê', 'e,e'), 'á,â,ã', 'a,a,a'), 'ô,ó,õ', 'o,o,o'),
	'ç', 'c'), 'ú,ü', 'u,u'), 'í', 'i'), 
	'4o', '4º'), '* ', ''), '%26apos%3b', ''''
) AS geolocation_city, geolocation_state
from geolocation_dirty gd;

CREATE TABLE geolocation AS
WITH geolocation AS (
	SELECT geolocation_zip_code_prefix,
	geolocation_lat, 
	geolocation_lng, 
	geolocation_city, 
	geolocation_state FROM (
		SELECT *,
			ROW_NUMBER() OVER (
				PARTITION BY geolocation_zip_code_prefix
			) AS ROW_NUMBER
		FROM geolocation_dirty2 
	) TEMP
	WHERE ROW_NUMBER = 1
),
custgeo AS (
	SELECT customer_zip_code_prefix, geolocation_lat, 
	geolocation_lng, customer_city, customer_state 
	FROM (
		SELECT *,
			ROW_NUMBER() OVER (
				PARTITION BY customer_zip_code_prefix
			) AS ROW_NUMBER
		FROM (
			SELECT customer_zip_code_prefix, geolocation_lat, 
			geolocation_lng, customer_city, customer_state
			FROM customers cd 
			LEFT JOIN geolocation_dirty gdd 
			ON customer_city = geolocation_city
			AND customer_state = geolocation_state
			WHERE customer_zip_code_prefix NOT IN (
				SELECT geolocation_zip_code_prefix
				FROM geolocation gd 
			)
		) geo
	) TEMP
	WHERE ROW_NUMBER = 1
),
sellgeo AS (
	SELECT seller_zip_code_prefix, geolocation_lat, 
	geolocation_lng, seller_city, seller_state 
	FROM (
		SELECT *,
			ROW_NUMBER() OVER (
				PARTITION BY seller_zip_code_prefix
			) AS ROW_NUMBER
		FROM (
			SELECT seller_zip_code_prefix, geolocation_lat, 
			geolocation_lng, seller_city, seller_state
			FROM sellers cd 
			LEFT JOIN geolocation_dirty gdd 
			ON seller_city = geolocation_city
			AND seller_state = geolocation_state
			WHERE seller_zip_code_prefix NOT IN (
				SELECT geolocation_zip_code_prefix
				FROM geolocation gd 
				UNION
				SELECT customer_zip_code_prefix
				FROM custgeo cd 
			)
		) geo
	) TEMP
	WHERE ROW_NUMBER = 1
)
SELECT * 
FROM geolocation
UNION
SELECT * 
FROM custgeo
UNION
SELECT * 
FROM sellgeo;

ALTER TABLE geolocation ADD CONSTRAINT geolocation_pk PRIMARY KEY (geolocation_zip_code_prefix);





-- =============== 3. Constraint & Foreign Key =============== 


--  products -> order_items

ALTER TABLE order_items 
ADD CONSTRAINT order_items_fk_product 
FOREIGN KEY (product_id) REFERENCES products(product_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- sellers -> order_items

ALTER TABLE order_items 
ADD CONSTRAINT order_items_fk_seller 
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- orders -> order_items

ALTER TABLE order_items 
ADD CONSTRAINT order_items_fk_order 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

--  orders -> order_payments

ALTER TABLE order_payments 
ADD CONSTRAINT order_payments_fk 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- orders -> order_reviews

ALTER TABLE order_reviews 
ADD CONSTRAINT order_reviews_fk 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- customers -> orders

ALTER TABLE orders 
ADD CONSTRAINT orders_fk 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- geolocation -> customers

ALTER TABLE customers 
ADD CONSTRAINT customers_fk 
FOREIGN KEY (customer_zip_code_prefix) REFERENCES geolocation(geolocation_zip_code_prefix) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- geolocation -> sellers

ALTER TABLE sellers 
ADD CONSTRAINT sellers_fk 
FOREIGN KEY (seller_zip_code_prefix) REFERENCES geolocation(geolocation_zip_code_prefix) 
ON DELETE CASCADE ON UPDATE CASCADE;


