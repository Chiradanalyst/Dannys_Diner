/*
Which item was purchased first by the customer after they became a member?
	Step 1
	- Create first CTE member_purchase
			- LEFT JOIN members and sales on customer_id
			- USED WHERE function after joining
				- this filters out the dates before the customers become members
	Step 2
	- Create second CTE occurrence
			- Used a WINDOW FUNCTION to RANK the order_by date
				- Earliest date ranked as 1
	Step 3
	- Finally, I filtered for only the first products that customers purchased
			- LEFT JOIN with menu on product_id 
			- Used a WHERE = 1 to filter for only the first date
			- Queried customer_id, product_name as first_purchased_item and added join_date & date to confirm the dates*/

WITH member_purchase AS (
SELECT members.customer_id,
	join_date,
	order_date AS date,
	product_id
FROM dannys_diner.members
LEFT JOIN dannys_diner.sales
ON dannys_diner.members.customer_id = dannys_diner.sales.customer_id
WHERE join_date <= order_date
	),

occurrence AS ( 
	SELECT *,
	ROW_NUMBER () OVER (PARTITION BY customer_id ORDER BY date ) AS "rank"            
    FROM member_purchase
	)

SELECT occurrence.customer_id, product_name as first_purchased_item , join_date, date
FROM occurrence
LEFT JOIN dannys_diner.menu
ON occurrence.product_id = dannys_diner.menu.product_id
WHERE RANK = 1
	



