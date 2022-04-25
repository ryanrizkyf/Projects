/* Task 2 */

-- Nomor 1 --
/* Menampilkan rata-rata jumlah customer aktif bulanan 
(monthly active user) untuk setiap tahun. 
(Hint: Perhatikan kesesuaian format tanggal)*/
SELECT
	year,
	ROUND(AVG(mau), 2) AS avg_mau
FROM (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		DATE_PART('month', o.order_purchase_timestamp) AS month,
		COUNT(DISTINCT c.customer_unique_id) AS mau
	FROM
		orders AS o
	JOIN
		customers AS c
	ON
		o.customers_id = c.customer_id
	GROUP BY
		year, month
) AS subquery	
GROUP BY
	year;
	
-- Nomor 2 --
/* Menampilkan jumlah customer baru pada masing-masing tahun. 
(Hint: Pelanggan baru adalah pelanggan yang melakukan order pertama kali)*/
SELECT
	DATE_PART('year', first_purchase) AS year,
	COUNT(1) AS new_customers
FROM (
	SELECT
		c.customer_unique_id,
		MIN(o.order_purchase_timestamp) AS first_purchase
	FROM
		orders AS o
	JOIN
		customers AS c
	ON
		c.customer_id = o.customers_id
	GROUP BY
		c.customer_unique_id
	) AS subquery
GROUP BY
	year;
	
-- Nomor 3 --
/* Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali 
(repeat order) pada masing-masing tahun. 
(Hint: Pelanggan yang melakukan repeat order adalah pelanggan yang melakukan order lebih dari 1 kali)*/
SELECT
	year,
	COUNT(DISTINCT customer_unique_id) AS customers_repeat_orders
FROM (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		c.customer_unique_id,
		COUNT(1) AS purchase_frequency
	FROM 
		orders AS o
	JOIN
		customers AS c
	ON
		c.customer_id = o.customers_id
	GROUP BY
		year,
		c.customer_unique_id
	HAVING
		COUNT(1) > 1
) AS subquery
GROUP BY
	year;
	
-- Nomor 4 --
/* Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun.
(Hint: Hitung frekuensi order (berapa kali order) untuk masing-masing customer terlebih dahulu)
*/
SELECT
	year,
	ROUND(AVG(frequency_purchase), 3) AS avg_orders
FROM (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		c.customer_unique_id,
		COUNT(1) AS frequency_purchase
	FROM
		orders AS o
	JOIN
		customers AS c
	ON
		c.customer_id = o.customers_id
	GROUP BY
		year,
		c.customer_unique_id
) AS subquery
GROUP BY
	year;

-- Nomor 5 --
/* Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel
*/
WITH mau AS (
	SELECT
	year,
	ROUND(AVG(mau), 2) AS avg_mau
FROM (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		DATE_PART('month', o.order_purchase_timestamp) AS month,
		COUNT(DISTINCT c.customer_unique_id) AS mau
	FROM 
		orders AS o
	JOIN 
		customers AS c 
	ON 
		o.customers_id = c.customer_id
	GROUP BY 
		1, 2
) AS subq
GROUP BY 
	1
),
newcust AS (
	SELECT
		DATE_PART('year', first_purchase) AS year,
		COUNT(1) AS new_customers
	FROM (
		SELECT
			c.customer_unique_id,
			MIN(o.order_purchase_timestamp) AS first_purchase
		FROM 
			orders AS o
		JOIN 
			customers AS c 
		ON 
			c.customer_id = o.customers_id
		GROUP BY 
			1
) AS subq
GROUP BY 
	1
),
repeat AS (
	SELECT
		year,
		COUNT(DISTINCT customer_unique_id) AS customers_repeat_orders
	FROM (
		SELECT
			DATE_PART('year', o.order_purchase_timestamp) AS year,
			c.customer_unique_id,
			count(1) AS purchase_frequency
		FROM 
			orders AS o
		JOIN 
			customers AS c 
		ON 
			c.customer_id = o.customers_id
		GROUP BY 
			1, 2
		HAVING 
			COUNT(1) > 1
) AS subq
GROUP BY 
	1
),
avg_freq AS (
	SELECT
		year,
		ROUND(AVG(frequency_purchase), 3) AS avg_orders
	FROM (
		select
			DATE_PART('year', o.order_purchase_timestamp) AS year,
			c.customer_unique_id,
			count(1) AS frequency_purchase
		FROM 
			orders AS o
		JOIN 
			customers AS c 
		ON 
			c.customer_id = o.customers_id
		GROUP BY 
			1, 2
) AS subquery
GROUP BY 
	1
)
SELECT
	mau.year,
	mau.avg_mau,
	newcust.new_customers,
	repeat.customers_repeat_orders,
	avg_freq.avg_orders
FROM 
	mau
JOIN 
	newcust
ON 
	mau.year = newcust.year
JOIN 
	repeat
ON 
	repeat.year = mau.year
JOIN 
	avg_freq
ON 
	avg_freq.year = mau.year;