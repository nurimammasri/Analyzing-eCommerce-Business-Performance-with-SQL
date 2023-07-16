--	====================== Annual Product Category Quality Analysis	====================== 

--	Created by: 
--	Nur Imam Masri
--	Email : nurimammasri.01@gmail.com
--	LinkedIn : linkedin.com/in/nurimammasri
--	Github : github.com/nurimammasri
--	Portfolio : bit.ly/ImamProjectPortfolio 

--  -----------------------------------------------------------------------------------------

--	Menganalisis performa dari masing-masing kategori produk yang ada dan bagaimana kaitannya dengan pendapatan perusahaan.

--	Langkah - langkah	:
--	1. Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun
--	Hint: Revenue adalah harga barang dan juga biaya kirim. Pastikan juga melakukan filtering terhadap order status yang tepat untuk menghitung pendapatan
--	2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun
--	Hint: Perhatikan filtering terhadap order status yang tepat untuk menghitung jumlah cancel order
--	3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun
--	Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan
--	4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun
--	Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan
--	5. Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel
--	Hint: Perhatikan teknik join yang dilakukan serta kolom-kolom yang dipilih

--	Resource 		: 
--	https://www.postgresql.org/docs/8.2/sql-createtableas.html
--	https://www.postgresql.org/docs/9.1/tutorial-window.html

--	Hasil			: 
--	1. Tabel revenue per tahun
--	2. Tabel jumlah cancel order per tahun
--	3. Tabel top kategori yang menghasilkan revenue terbesar per tahun
--	4. Tabel kategori yang mengalami cancel order terbanyak per tahun
--	5. Master tabel yang berisi informasi-informasi di atas



-- RESET TABLE

-- To ensure the results do not increase or differ from the initial input

DROP TABLE IF EXISTS total_revenue_year; 
DROP TABLE IF EXISTS total_canceled_orders_year;
DROP TABLE IF EXISTS top_product_category_revenue_year; 
DROP TABLE IF EXISTS top_product_category_canceled_year; 


--	1. Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun
--	Hint: Revenue adalah harga barang dan juga biaya kirim. Pastikan juga melakukan filtering terhadap order status yang tepat untuk menghitung pendapatan

-- - Create CTE revenue_orders to store the amount of revenue for each order, this is to reduce computation on joins
-- - Revenue is obtained by adding up the price and freight value
-- - Using the aggregation function to add up the amount of revenue from orders each year
-- - Setting filter = 'delivered' because it is necessary to approve that the transaction is fully completed

CREATE TABLE total_revenue_year AS 
WITH revenue_orders AS (
	SELECT 
		order_id,
		sum(price + freight_value) AS revenue
	FROM order_items oi
	GROUP BY 1
)
SELECT 
	date_part('year', o.order_purchase_timestamp) AS year,
	sum(po.revenue) AS revenue
FROM orders o 
JOIN revenue_orders po
ON o.order_id = po.order_id 
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;


--	2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun
--	Hint: Perhatikan filtering terhadap order status yang tepat untuk menghitung jumlah cancel order

-- - Using the aggregation function to add up the number of orders from orders each year
-- - Setting filter = 'canceled' because it is necessary to approve that the transaction is canceled

CREATE TABLE total_canceled_orders_year AS 
SELECT 
	date_part('year', order_purchase_timestamp) AS year,
	count(order_id) AS total_cancel
FROM orders o
WHERE order_status = 'canceled'
GROUP BY 1
ORDER BY 1;


--	3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun
--	Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan

-- - Create CTE for total revenue for each product category each year.
-- - Using the window function ROW_NUMBER() to rank revenue
-- - Setting filter rank = 1 to get the top product category each year

CREATE TABLE top_product_category_revenue_year AS 
WITH revenue_category_orders AS (
	SELECT 
		date_part('year', o.order_purchase_timestamp) AS year,
		p.product_category_name,
		sum(oi.price + oi.freight_value) AS revenue,
		ROW_NUMBER() OVER(
			PARTITION BY date_part('year', o.order_purchase_timestamp) 
			ORDER BY sum(oi.price + oi.freight_value) desc
		) AS rank
	FROM orders o 
	JOIN order_items oi
	ON o.order_id = oi.order_id 
	JOIN products p 
	ON oi.product_id = p.product_id 
	WHERE order_status = 'delivered'
	GROUP BY 1, 2
)
SELECT 
	year, 
	product_category_name,
	revenue
FROM revenue_category_orders
WHERE rank = 1;


--	4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun
--	Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan

-- - Create a CTE for the number of orders canceled for each product category each year.
-- - Uses the window function ROW_NUMBER() to rank the number of canceled numbers
-- - Setting filter rank = 1 to get the top cancel product category each year

CREATE TABLE top_product_category_canceled_year AS 
WITH canceled_category_orders AS (
	SELECT 
		date_part('year', o.order_purchase_timestamp) AS year,
		p.product_category_name,
		count(*) AS total_cancel,
		ROW_NUMBER() OVER(
			PARTITION BY date_part('year', o.order_purchase_timestamp) 
			ORDER BY count(*) desc
		) AS rank
	FROM orders o 
	JOIN order_items oi
	ON o.order_id = oi.order_id 
	JOIN products p 
	ON oi.product_id = p.product_id 
	WHERE order_status = 'canceled'
	GROUP BY 1, 2
)
SELECT 
	year, 
	product_category_name,
	total_cancel
FROM canceled_category_orders
WHERE rank = 1;


--	5. Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel
--	Hint: Perhatikan teknik join yang dilakukan serta kolom-kolom yang dipilih

SELECT 
	tpr.year, 
	tpr.product_category_name AS top_product_category_revenue, 
	tpr.revenue AS top_category_revenue, 
	try.revenue AS total_revenue_year,
	tpc.product_category_name AS top_product_category_canceled,
	tpc.total_cancel AS top_category_num_canceled,
	tco.total_cancel AS total_canceled_orders_year
FROM top_product_category_revenue_year tpr
JOIN total_revenue_year try 
ON tpr.year = try.year
JOIN top_product_category_canceled_year tpc
ON tpr.year = tpc.year
JOIN total_canceled_orders_year tco 
ON tpr.year = tco.YEAR;


