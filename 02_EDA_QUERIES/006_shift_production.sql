WITH order_day AS(
	SELECT 	o.created_at,
			sum(order_quantity) as order_quantity,
			CASE
				 WHEN EXTRACT(HOUR FROM created_at) < 10 
            	OR (EXTRACT(HOUR FROM created_at) = 10 AND EXTRACT(MINUTE FROM created_at) < 30) 
				THEN 'morning shift'
				ELSE 'afternoon shift'
				END AS working_shifts
	FROM 	order_item as oi LEFT JOIN orders as o
			ON oi.id_order = o.id_order
	GROUP BY o.created_at
	ORDER BY o.created_at
)
	SELECT working_shifts,
			sum(order_quantity) AS total_quantity
	FROM	order_day
	GROUP BY working_shifts
	