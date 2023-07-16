--	====================== Annual Customer Activity Growth Analysis	====================== 

--	Created by: 
--	Nur Imam Masri
--	Email : nurimammasri.01@gmail.com
--	LinkedIn : linkedin.com/in/nurimammasri
--	Github : github.com/nurimammasri
--	Portfolio : bit.ly/ImamProjectPortfolio 

--  -----------------------------------------------------------------------------------------

--	Melihat dan menganalisis apakah performa bisnis eCommerce dari sisi aktivitas customer mengalami 
--	pertumbuhan, stagnan atau bahkan mengalami penurunan dalam kurun waktu tahunan. 

--	Langkah - langkah	:
--	1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk  setiap tahun
--	Hint: Perhatikan kesesuaian format tanggal 
--	2. Menampilkan jumlah customer baru pada masing-masing tahun
--	Hint: Pelanggan baru adalah pelanggan yang melakukan order pertama kali
--	3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun
--	Hint: Pelanggan yang melakukan repeat order adalah pelanggan yang melakukan order lebih dari 1 kali
--	4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun
--	Hint: Hitung frekuensi order (berapa kali order) untuk masing-masing customer terlebih dahulu
--	5. Menggabungkan keempat metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel
--	Hint: Lakukan pembuatan tabel sementara terhadap subtask-subtask sebelumnya terlebih dahulu

--	Resource 		: 
--	https://www.postgresqltutorial.com/postgresql-date_part/
--	https://www.postgresqltutorial.com/postgresql-group-by/
--	https://www.postgresqltutorial.com/postgresql-subquery/
--	https://www.postgresql.org/docs/9.1/queries-with.html
--	https://www.geeksforgeeks.org/postgresql-joins/

--	Hasil			: 
--	1. Rata-rata Monthly Active User (MAU) per tahun
--	2. Total customer baru per tahun
--	3. Jumlah customer yang melakukan repeat order per tahun
--	3. Rata-rata frekuensi order untuk setiap tahun
--	4. Master tabel yang berisi semua informasi di atas



--	1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk  setiap tahun
--	Hint: Perhatikan kesesuaian format tanggal

--	- Create a subquery that shows the number of customers in each month in each year
--	- Perform the aggregation function to get the average monthly customer per year

SELECT 
	year, 
	floor(avg(n_customers)) AS avg_monthly_active_user
FROM (
	SELECT 
		date_part('year', o.order_purchase_timestamp) AS year,
		date_part('month', o.order_purchase_timestamp) AS month,
		count(DISTINCT c.customer_unique_id) AS n_customers
	FROM orders o
	JOIN customers c 
	ON o.customer_id = c.customer_id 
	GROUP BY 1,2
) monthly
GROUP BY 1
ORDER BY 1;


--	2. Menampilkan jumlah customer baru pada masing-masing tahun
--	Hint: Pelanggan baru adalah pelanggan yang melakukan order pertama kali

--	- Create a subquery that shows first date orders from each customer
--	- Perform the aggregation function to get the number of new customers per year

SELECT 
	date_part('year', first_date_order) AS year,
	count(customer_unique_id) AS new_customers
FROM (
	SELECT 
		c.customer_unique_id, 
		min(o.order_purchase_timestamp) AS first_date_order
	FROM orders o 
	JOIN customers c 
	ON o.customer_id = c.customer_id 
	GROUP BY 1
) first_order
GROUP BY 1
ORDER BY 1;


--	3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun
--	Hint: Pelanggan yang melakukan repeat order adalah pelanggan yang melakukan order lebih dari 1 kali

-- - Create a subquery that shows the number of orders for each customer
-- - Do a filter on customers who have the number of orders > 1
-- - Perform the aggregation function to get the number of customers who make repeat orders

SELECT 
	year,
	count(DISTINCT customer_unique_id) AS repeat_customers
FROM (
	SELECT 
		date_part('year', o.order_purchase_timestamp) AS year,
		c.customer_unique_id,
		count(c.customer_unique_id) AS n_customer,
		count(o.order_id) AS n_order
	FROM orders o 
	JOIN customers c 
	ON o.customer_id = c.customer_id 
	GROUP BY 1,2
	HAVING count(o.order_id) > 1
) repeat_order
GROUP BY 1
ORDER BY 1;


--	4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun
--	Hint: Hitung frekuensi order (berapa kali order) untuk masing-masing customer terlebih dahulu

-- - Create a subquery that shows the number of orders for each customer
-- - Perform aggregation function to get average orders per year

SELECT 
	year,
	round(avg(n_order), 2) AS avg_num_orders
FROM (
	SELECT 
		date_part('year', o.order_purchase_timestamp) AS year,
		c.customer_unique_id,
		count(c.customer_unique_id) AS n_customer,
		count(o.order_id) AS n_order
	FROM orders o 
	JOIN customers c 
	ON o.customer_id = c.customer_id 
	GROUP BY 1,2
) order_customer
GROUP BY 1
ORDER BY 1;


--	5. Menggabungkan keempat metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel
--	Hint: Lakukan pembuatan tabel sementara terhadap subtask-subtask sebelumnya terlebih dahulu

WITH tbl_mau AS (
	SELECT 
		year, 
		floor(avg(n_customers)) AS avg_monthly_active_user
	FROM (
		SELECT 
			date_part('year', o.order_purchase_timestamp) AS year,
			date_part('month', o.order_purchase_timestamp) AS month,
			count(DISTINCT c.customer_unique_id) AS n_customers
		FROM orders o
		JOIN customers c 
		ON o.customer_id = c.customer_id 
		GROUP BY 1,2
	) monthly
	GROUP BY 1
),
tbl_newcust AS (
	SELECT 
		date_part('year', first_date_order) AS year,
		count(customer_unique_id) AS new_customers
	FROM (
		SELECT 
			c.customer_unique_id, 
			min(o.order_purchase_timestamp) AS first_date_order
		FROM orders o 
		JOIN customers c 
		ON o.customer_id = c.customer_id 
		GROUP BY 1
	) first_order
	GROUP BY 1
),
tbl_repcust AS (
	SELECT 
		year,
		count(DISTINCT customer_unique_id) AS repeat_customers
	FROM (
		SELECT 
			date_part('year', o.order_purchase_timestamp) AS year,
			c.customer_unique_id,
			count(c.customer_unique_id) AS n_customer,
			count(o.order_id) AS n_order
		FROM orders o 
		JOIN customers c 
		ON o.customer_id = c.customer_id 
		GROUP BY 1,2
		HAVING count(o.order_id) > 1
	) repeat_order
	GROUP BY 1
),
tbl_avgorder AS (
	SELECT 
		year,
		round(avg(n_order), 2) AS avg_num_orders
	FROM (
		SELECT 
			date_part('year', o.order_purchase_timestamp) AS year,
			c.customer_unique_id,
			count(c.customer_unique_id) AS n_customer,
			count(o.order_id) AS n_order
		FROM orders o 
		JOIN customers c 
		ON o.customer_id = c.customer_id 
		GROUP BY 1,2
	) order_customer
	GROUP BY 1
)
SELECT 
	tm.year, 
	tm.avg_monthly_active_user, 
	tn.new_customers, 
	tr.repeat_customers, 
	ta.avg_num_orders
FROM tbl_mau tm
JOIN tbl_newcust tn
ON tm.year = tn.year 
JOIN tbl_repcust tr
ON tm.year = tr.year 
JOIN tbl_avgorder ta
ON tm.year = ta.year 
ORDER BY 1;


