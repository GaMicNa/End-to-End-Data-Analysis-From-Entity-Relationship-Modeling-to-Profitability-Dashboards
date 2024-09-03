WITH products_quantity AS(
SELECT 	TO_CHAR(c.date, 'YYYY-MM') AS year_month,
		i.id_item,
		i.item_name,
		SUM(oi.order_quantity) AS quantity
FROM 	orders AS o LEFT JOIN order_item AS oi
		ON o.id_order=oi.id_order
		LEFT JOIN calendar AS c
		ON o.id_date=c.id_date
		LEFT JOIN item AS i
		ON oi.id_item=i.id_item
GROUP BY year_month,
		i.id_item,
		i.item_name
ORDER BY year_month ASC
)

SELECT 	pq.year_month,
		ig.ing_id,
		ig.ing_name,
		ROUND(SUM(pq.quantity * r.quantity)::NUMERIC, 2) AS cantidad,
		ig.measure_unit
FROM products_quantity AS pq LEFT JOIN recipe as r
	ON pq.id_item=r.id_item
	LEFT JOIN ingredients AS ig
	ON r.id_ing = ig.id_ing
GROUP BY pq.year_month,
		ig.ing_id,
		ig.ing_name, 
		ig.measure_unit
ORDER BY pq.year_month
;	