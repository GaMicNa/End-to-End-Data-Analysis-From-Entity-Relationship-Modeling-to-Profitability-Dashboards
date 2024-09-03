SELECT TO_CHAR(o.created_at, 'month') as MES,
		i.type as item,
		SUM (oi.order_quantity) as quantity
FROM orders AS o LEFT JOIN order_item AS oi
		ON o.id_order=oi.id_order
		LEFT JOIN item AS i
		ON oi.id_item=i.id_item
GROUP BY TO_CHAR(o.created_at, 'month'),
		 EXTRACT(month from o.created_at),
		i.type
ORDER BY  EXTRACT(month from o.created_at)
;		
