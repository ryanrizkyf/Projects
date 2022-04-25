/* Task 4 */

-- Nomor 1 --
/*
Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit.
(Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan)
*/
SELECT
	p.payment_type,
	COUNT(1) AS total_used
FROM
	payments AS p
JOIN
	orders AS o
ON
	o.order_id = p.order_id
GROUP BY
	1
ORDER BY
	2 DESC;

-- Nomor 2 --
/*
Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun.
(Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan)
*/
WITH tmp AS (
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		p.payment_type,
		COUNT(1) AS total_used
	FROM 
		payments AS p
	JOIN
		orders AS o
	ON
		o.order_id = p.order_id
	GROUP BY
		1, 2
)
SELECT
	*,
	CASE WHEN
			year_2017 = 0 THEN NULL
		ELSE
			ROUND((year_2018 - year_2017) / year_2017, 2)
		END AS pct_change_2017_2018
FROM (
	SELECT
		payment_type,
		SUM(CASE WHEN
					year = '2016' THEN total_used
	   		ELSE 0 END) AS year_2016,
		SUM(CASE WHEN
	   				year = '2017' THEN total_used
	   		ELSE 0 END) AS year_2017,
		SUM(CASE WHEN
	   				year = '2018' THEN total_used
	  	 	ELSE 0 END) AS year_2018
	FROM 
		tmp
	GROUP BY
		1) AS subquery
ORDER BY 5 DESC;