SELECT 
	date_part('year', o.order_purchase_timestamp) AS year,
	date_part('month', o.order_purchase_timestamp) AS month_num,
	TO_CHAR(o.order_purchase_timestamp, 'Mon') AS month,
	count(DISTINCT c.customer_unique_id) AS n_customers
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY 1,2,3
ORDER BY 1,2;


SELECT 
	date(o.order_purchase_timestamp),
	count(DISTINCT c.customer_unique_id) AS n_customers
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY 1
ORDER BY 1