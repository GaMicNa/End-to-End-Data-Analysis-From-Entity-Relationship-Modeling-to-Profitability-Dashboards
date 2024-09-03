WITH order_day AS(
	SELECT 	c.date,
			sum(order_quantity) as order_quantity
	FROM 	order_item as oi LEFT JOIN orders as o
			ON oi.id_order = o.id_order
			LEFT JOIN calendar as c
			ON o.id_date = c.id_date
	GROUP BY c.date
	ORDER BY c.date
), 
work_group_day AS(
	SELECT	DISTINCT c.date,
			st.work_group
	FROM	staff AS st LEFT JOIN rota as rt
			ON st.id_staff = rt.id_staff
			LEFT JOIN calendar as c
			ON rt.id_date = c.id_date
	WHERE 	st.work_group < 3
	ORDER BY c.date
)
SELECT	
		wg.work_group,
		SUM(od.order_quantity) AS total_salteña
		
FROM order_day AS od LEFT JOIN work_group_day AS wg
	ON od.date = wg.date
GROUP BY wg.work_group
ORDER BY wg.work_group ASC
