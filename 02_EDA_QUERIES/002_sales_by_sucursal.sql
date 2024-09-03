SELECT 
		st.name_store as store,	
		SUM (oi.order_quantity) as quantity
FROM orders AS o LEFT JOIN order_item AS oi
		ON o.id_order=oi.id_order
		LEFT JOIN calendar AS c
		ON o.id_date=c.id_date
		LEFT JOIN item AS i
		ON oi.id_item=i.id_item
		LEFT JOIN saltria_store as st
		ON st.id_store=o.id_store
GROUP BY 
		 st.name_store	
ORDER BY quantity DESC
;	