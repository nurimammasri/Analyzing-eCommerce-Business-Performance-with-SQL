-- ================== PRIMARY KEYS ================== 
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-primary-key/

--	Note : 
--	Tab -> INDENT
--	Shift + Tab -> Back Tab


--	CREATE TABLE TABLE (
--		column_1 data_type PRIMARY KEY,
--		column_2 data_type,
--		…
--	);

--	CREATE TABLE TABLE (
--		column_1 data_type,
--		column_2 data_type,
--		… 
--	        PRIMARY KEY (column_1, column_2)
--	);


--	In case you want to specify the name of the primary key 
--	constraint, you use CONSTRAINT clause as follows:

--	CONSTRAINT constraint_name PRIMARY KEY(column_1, column_2,...);


--	Define primary key when changing the existing table structure

--	ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);

--	ALTER TABLE customers 
--	ADD PRIMARY KEY (customer_id);
--		
--	ALTER TABLE customers 
--	ADD CONSTRAINT customers_pk PRIMARY KEY (customer_id);


--	Remove primary key

--	To remove an existing primary key constraint, you also use the ALTER TABLE statement with the following syntax:
--	
--	ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;



-- CARA MEMBUAT PRIMARY KEY MELALUI DBEAVER

--	1. Pilih tablenya
--	2. Masuk ke Tab Properties
--	3. Masuk ke tab samping "Columns"
--	4. Klik kanan pada nama COLUMN yang ingin kita jadikan PRIMARY KEY
--	5. pilih new constraint from selection
--  6. pastikan memilih type "Primary Key"

-- CARA MEMBUAT PRIMARY KEY MELALUI PGADMIN

--	1. Klik kanan pada TABLE > Properties
--	2. Masuk ke tab COLUMNS
--	3. Ceklis pada NOT NULL dan PRIMARY KEY 


-- ================== FOREIGN KEYS ================== 
--	https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-foreign-key/

--	A Foreign Key is a database key that is used to link two tables 
--	together. The FOREIGN KEY constraint identifies the relationships 
--	between the database tables by referencing a column, or set of 
--	columns, in the Child table that contains the foreign key, to 
--	the PRIMARY KEY column or set of columns, in the Parent table.

--	The following illustrates a foreign key constraint syntax:
--	
--	[CONSTRAINT fk_name]
--	   FOREIGN KEY(fk_columns) 
--	   REFERENCES parent_table(parent_key_columns)
--	   [ON DELETE delete_action]
--	   [ON UPDATE update_action]
--	
--	
--	In this syntax:
--	
--	- First, specify the name for the foreign key constraint after the CONSTRAINT keyword. The CONSTRAINT clause is optional. If you omit it, PostgreSQL will assign an auto-generated name.
--	- Second, specify one or more foreign key columns in parentheses after the FOREIGN KEY keywords.
--	- Third, specify the parent table and parent key columns referenced by the foreign key columns in the REFERENCES clause.
--	- Finally, specify the delete and update actions in the ON DELETE and ON UPDATE clauses.
--	
--	The delete and update actions determine the behaviors when the 
--	primary key in the parent table is deleted and updated. Since 
--	the primary key is rarely updated, the ON UPDATE action is not 
--	often used in practice. We’ll focus on the ON DELETE action.
--	
--	PostgreSQL supports the following actions:
--	
--	- SET NULL
--	- SET DEFAULT
--	- RESTRICT
--	- NO ACTION
--	- CASCADE

--	- ON DELETE
--	Optional. It specifies what to do with the child data when the parent data is deleted. You have the options of NO ACTION, CASCADE, SET NULL, or SET DEFAULT.
--	
--	- ON UPDATE
--	Optional. It specifies what to do with the child data when the parent data is updated. You have the options of NO ACTION, CASCADE, SET NULL, or SET DEFAULT.
--	
--	- NO ACTION
--	It is used in conjunction with ON DELETE or ON UPDATE. It means that no action is performed with the child data when the parent data is deleted or updated.
--	
--	- CASCADE
--	It is used in conjunction with ON DELETE or ON UPDATE. It means that the child data is either deleted or updated when the parent data is deleted or updated.
--	
--	- SET NULL
--	It is used in conjunction with ON DELETE or ON UPDATE. It means that the child data is set to NULL when the parent data is deleted or updated.
--	
--	- SET DEFAULT
--	It is used in conjunction with ON DELETE or ON UPDATE. It means that the child data is set to their default values when the parent data is deleted or updated.

--	CREATE TABLE contacts(
--	   contact_id INT GENERATED ALWAYS AS IDENTITY,
--	   customer_id INT,
--	   contact_name VARCHAR(255) NOT NULL,
--	   phone VARCHAR(15),
--	   email VARCHAR(100),
--	   PRIMARY KEY(contact_id),
--	   CONSTRAINT fk_customer
--	      FOREIGN KEY(customer_id) 
--		  REFERENCES customers(customer_id)
--		  ON DELETE CASCADE
--	);

--	Because the foreign key constraint does not have the ON DELETE and ON UPDATE action, they default to NO ACTION.


--	Add a foreign key constraint to an existing TABLE
--	
--	ALTER TABLE child_table
--	ADD CONSTRAINT constraint_fk
--	FOREIGN KEY (fk_columns)
--	REFERENCES parent_table(parent_key_columns)
--	ON DELETE CASCADE;


--  Remove Foreign Key

--	ALTER TABLE table_name   
--	DROP CONSTRAINT constraint_fkey;  



-- CARA MEMBUAT FOREIGN KEY MELALUI DBEAVER

--	1. Pilih tablenya
--	2. Masuk ke Tab Properties
--	3. Masuk ke tab samping "Foreign Keys"
--	4. Klik kanan dimana saja > Create New Foreign Key
--	5. pilih  reference tablesnya, dan typenya virtual unique
--  6. Tentukan column yang akan kita hubungkan
--  7. Ubah On Update / On Delete type kalau mau


-- CARA MEMBUAT PRIMARY KEY MELALUI PGADMIN

--	1. Klik kanan pada TABLE > Properties
--	2. Masuk ke tab Constraint
--	3. Pilih pada tab Foreign Keys
--  4. Pada pojok kanan atas ada tanda +
--  5. Silahkan masukkan nama constraint, dan melengkapi column dan action



-- ======= product ======= 

ALTER TABLE product
ADD CONSTRAINT product_pk PRIMARY KEY (product_id)

-- ======= order_payment ======= 

--select order_id, count(*)
--from order_payments opd 
--group by order_id
--HAVING count(*) > 1

-- ======= order_reviews ======= 

--select review_id, count(*)
--from order_reviews ord 
--group by review_id
--HAVING count(*) > 1

--select order_id, count(*)
--from order_reviews ord 
--group by order_id
--HAVING count(*) > 1

-- ======= orders ======= 

ALTER TABLE orders
ADD CONSTRAINT orders_pk PRIMARY KEY (order_id)

-- ======= customers ======= 
ALTER TABLE customers 
ADD CONSTRAINT customers_pk PRIMARY KEY (customer_id);

-- ======= geolocation ======= 

select geolocation_zip_code_prefix, count(*)
from geolocation gd 
group by geolocation_zip_code_prefix 
HAVING count(*) > 1

-- ======= seller ======= 

ALTER TABLE sellers 
ADD CONSTRAINT sellers_pk PRIMARY KEY (seller_id);

-- ======= order_items ======= 

--select seller_id , count(*)
--from order_items oid2 
--group by seller_id  
--HAVING count(*) > 1



-- FOREIGN KEY

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


