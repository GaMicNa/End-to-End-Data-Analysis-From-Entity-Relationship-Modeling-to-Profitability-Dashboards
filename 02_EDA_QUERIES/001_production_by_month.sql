SELECT TO_CHAR(c.date, 'month') as MES,
		i.type as item,
		SUM (oi.order_quantity) as quantity
FROM orders AS o LEFT JOIN order_item AS oi
		ON o.id_order=oi.id_order
		LEFT JOIN calendar AS c
		ON o.id_date=c.id_date
		LEFT JOIN item AS i
		ON oi.id_item=i.id_item
GROUP BY TO_CHAR(c.date, 'month'),
		 EXTRACT(month from c.date),
		i.type
ORDER BY  EXTRACT(month from c.date)
;		

