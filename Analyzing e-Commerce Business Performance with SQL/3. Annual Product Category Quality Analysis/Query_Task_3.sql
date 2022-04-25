/* Task 3 */

-- Nomor 1 --
/* Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun.
(Hint: Revenue adalah harga barang dan juga biaya kirim. 
Pastikan juga melakukan filtering terhadap order status yang tepat untuk menghitung pendapatan)
*/
CREATE TABLE total_revenue AS
SELECT
	DATE_PART('year', o.order_purchase_timestamp) AS year,
	SUM(revenue_per_order) AS revenue
FROM (
	SELECT
		order_id,
		SUM(price + freight_value) AS revenue_per_order
	FROM
		order_item
	GROUP BY
		order_id
) AS subquery
JOIN
	orders AS o
ON
	subquery.order_id = o.order_id
WHERE
	o.order_status = 'delivered'
GROUP BY
	year;
	

-- Nomor 2 --
/*
Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun.
(Hint: Perhatikan filtering terhadap order status yang tepat untuk menghitung jumlah cancel order)
*/
CREATE TABLE total_cancel AS
SELECT
	DATE_PART('year', order_purchase_timestamp) AS year,
	COUNT(1) AS cancel_orders
FROM
	orders
WHERE
	order_status = 'canceled'
GROUP BY
	year;

-- Nomor 3 --
/*
Membuat tabel yang berisi nama kategori produk yang memberikan 
pendapatan total tertinggi untuk masing-masing tahun.
(Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)
*/
CREATE TABLE top_product_category_by_revenue AS
SELECT
	year,
	product_category_name,
	revenue
FROM (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		p.product_category_name,
		SUM(oi.price + oi.freight_value) AS revenue,
		RANK() OVER (PARTITION BY
				 		DATE_PART('year', o.order_purchase_timestamp)
					ORDER BY
				 		SUM(oi.price + oi.freight_value) DESC) AS rank
	FROM
		order_item AS oi
	JOIN
		orders AS o
	ON
		o.order_id = oi.order_id
	JOIN
		products AS p
	ON
		p.product_id = oi.product_id
	WHERE
		o.order_status = 'delivered'
	GROUP BY
		1, 2) AS subquery
WHERE rank = 1;

-- Nomor 4 --
/*
Membuat tabel yang berisi nama kategori produk yang memiliki 
jumlah cancel order terbanyak untuk masing-masing tahun.
(Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)
*/
CREATE TABLE most_cancel_product_category AS
SELECT
	year,
	product_category_name,
	cancel
FROM (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		p.product_category_name,
		COUNT(1) AS cancel,
		RANK() OVER(PARTITION BY
				   		DATE_PART('year', o.order_purchase_timestamp)
				   ORDER BY COUNT(1) DESC) AS rank
	FROM
		order_item AS oi
	JOIN
		orders AS o
	ON
		o.order_id = oi.order_id
	JOIN
		products AS p
	ON
		p.product_id = oi.product_id
	WHERE 
		o.order_status = 'canceled'
	GROUP BY
	1, 2) AS subquery
WHERE rank = 1;

-- Nomor 5 --
/*
Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel.
(Hint: Perhatikan teknik join yang dilakukan serta kolom-kolom yang dipilih)
*/
SELECT
	a.year,
	a.product_category_name AS top_product_category_by_revenue,
	a.revenue AS category_revenue,
	b.revenue AS year_total_revenue,
	c.product_category_name AS most_cancel_product_category,
	c.cancel AS category_total_canceled,
	d.cancel_orders AS year_total_canceled
FROM 
	top_product_category_by_revenue AS a
JOIN 
	total_revenue AS b 
ON 
	a.year = b.year
JOIN 
	most_cancel_product_category AS c 
ON 
	a.year = c.year
JOIN 
	total_cancel AS d 
ON 
	d.year = a.year;