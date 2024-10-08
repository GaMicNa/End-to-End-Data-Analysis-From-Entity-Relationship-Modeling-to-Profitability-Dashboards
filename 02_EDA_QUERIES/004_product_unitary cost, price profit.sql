WITH supplies_cost_unit AS (
SELECT 	
		i.item_name AS item,      
		sum(r.quantity * ig.unit_price)::NUMERIC AS costo
FROM 	
		item AS i
LEFT
JOIN recipe AS r
		ON i.id_item=r.id_item
		LEFT
JOIN ingredients AS ig
		ON r.id_ing=ig.id_ing
GROUP BY 
		i.item_name
ORDER BY i.item_name
),        
 
labour_cost AS (
SELECT 
	SUM(payed_time) AS payed_time_total
FROM(
	SELECT 
		sum((EXTRACT(EPOCH FROM ((sh.end_time-sh.start_time))/3600)) * st.hourly_rate)::NUMERIC AS payed_time
	FROM staff AS st
LEFT
JOIN rota AS rt
		ON st.id_staff= rt.id_staff
		LEFT
JOIN shift AS sh
		ON rt.id_shift=sh.id_shift
		
GROUP BY st.hourly_rate) AS pago_horas
	),
        
total_products AS (
SELECT 
	sum(order_quantity) AS total_quantity
FROM 
	order_item
),

unitary_labour_cost AS (
SELECT 
		(payed_time_total/total_quantity) AS unitary_labour_cost
FROM 
		labour_cost,     
 		total_products
)
SELECT item, unitary_cost, unitary_price,
	unitary_price - unitary_cost AS unitary_profit
FROM (
	SELECT 
			sc.item,
			ROUND(sc.costo+ul.unitary_labour_cost, 2) AS unitary_cost,
			ROUND(((sc.costo+ul.unitary_labour_cost)*1.1), 1) AS unitary_price
	FROM 	
			supplies_cost_unit AS sc,
			unitary_labour_cost AS ul
	ORDER BY
			unitary_cost DESC
	) AS mix
;	