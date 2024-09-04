WITH order_day AS(
	SELECT 	i.item_name, o.created_at,
			sum(order_quantity) as order_quantity,
			CASE
				 WHEN EXTRACT(HOUR FROM created_at) < 10 
            	OR (EXTRACT(HOUR FROM created_at) = 10 AND EXTRACT(MINUTE FROM created_at) < 30) 
				THEN 'dawn shift'
				ELSE 'morning shift'
				END AS working_shifts
	FROM 	order_item as oi LEFT JOIN orders as o
			ON oi.id_order = o.id_order
			LEFT JOIN item as i
			ON i.id_item=oi.id_item
	GROUP BY i.item_name, o.created_at
	ORDER BY o.created_at
)
	SELECT item_name, working_shifts,
			sum(order_quantity) AS total_quantity
	FROM	order_day
	GROUP BY item_name, working_shifts
	ORDER BY working_shifts
	