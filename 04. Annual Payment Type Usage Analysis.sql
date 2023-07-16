--	====================== Annual Payment Type Usage Analysis ====================== 

--	Created by: 
--	Nur Imam Masri
--	Email : nurimammasri.01@gmail.com
--	LinkedIn : linkedin.com/in/nurimammasri
--	Github : github.com/nurimammasri
--	Portfolio : bit.ly/ImamProjectPortfolio 

--  -----------------------------------------------------------------------------------------

--	Menganalisis tipe-tipe pembayaran yang tersedia dan melihat tren perubahan yang terjadi selama beberapa tahun terakhir.

--	Langkah - langkah	:
--	1. Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit 
--	Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan
--	2. Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun
--	Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan

--	Resource 		: 
--	https://www.postgresqltutorial.com/postgresql-case/

--	Hasil			: 
--	1. Jumlah penggunaan masing-masing jenis pembayaran all time
--	2. Detail jumlah penggunaan masing-masing jenis pembayaran untuk setiap tahun
--	3. Satu tabel summary jumlah penggunaan tipe-tipe pembayaran untuk masing-masing tahun.




--	1. Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit 
--	Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan

-- - Create a table that shows the amount of payment usage for each type of payment for all time
-- - Sort data number of usage from the largest to the smallest payment type

SELECT 
	op.payment_type,
	count(*) AS num_of_usage
FROM orders o 
JOIN order_payments op 
ON o.order_id = op.order_id
GROUP BY 1
ORDER BY 2 DESC; 


--	2. Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun
--	Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan

-- - Create a table that shows the amount of payment usage for each type of payment for each year
-- - Sort data number of usage from the largest to the smallest payment type

SELECT 
	date_part('year', o.order_purchase_timestamp) as year,
	op.payment_type,
	count(*) AS num_of_usage 
FROM orders o 
JOIN order_payments op 
ON o.order_id = op.order_id
GROUP BY 1,2
ORDER BY 1 ASC, 3 DESC;


--	3. Satu tabel summary jumlah penggunaan tipe-tipe pembayaran untuk masing-masing tahun.

-- - Utilize the CASE WHEN function to pivot data (rows : payment_type, columns : year)
-- - Combining CASE WHEN into an aggregate function with year value windowing for dividing values in the column
-- - Sort data number of usage from the largest to the smallest payment type

-- Cara 1
WITH type_payments AS (
	SELECT 
		date_part('year', o.order_purchase_timestamp) as year,
		op.payment_type,
		count(*) AS num_of_usage 
	FROM orders o 
	JOIN order_payments op 
	ON o.order_id = op.order_id
	GROUP BY 1,2
)
select 
  payment_type,
  sum(case when year = '2016' then num_of_usage else 0 end) as year_2016,
  sum(case when year = '2017' then num_of_usage else 0 end) as year_2017,
  sum(case when year = '2018' then num_of_usage else 0 end) as year_2018
from type_payments
GROUP BY 1
ORDER BY 4 DESC;



-- Cara 2
SELECT
	payment_type,
	count(CASE WHEN date_part('year', order_purchase_timestamp) = '2016' THEN o.order_id END) AS year_2016,
	count(CASE WHEN date_part('year', order_purchase_timestamp) = '2017' THEN o.order_id END) AS year_2017,
	count(CASE WHEN date_part('year', order_purchase_timestamp) = '2018' THEN o.order_id END) AS year_2018
FROM orders o
JOIN order_payments op 
ON o.order_id = op.order_id 
GROUP BY 1
ORDER BY 4 DESC;


