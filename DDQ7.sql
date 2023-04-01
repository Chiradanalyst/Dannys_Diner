/*
Which item was purchased just before the customer became a member?

	Step 1 Create member_purchase CTE
		- LEFT JOINED sales & members on customer_id
		- Used a WHERE Function to filter for dates before join_date
	Step 2
		- created second CTE occurrence
		- Used a WINDOW function to rank purchases in a DESC order to get the last date first
	Step 3
	- Finally, I filtered for only the last product that customers purchased before becoming members
			- LEFT JOIN with menu on product_id 
			- Used a WHERE = 1 to filter for only the first date
			- Queried customer_id, product_name as first_purchased_item and added join_date & date to confirm the dates
*/

WITH member_purchase AS (
SELECT members.customer_id,
	join_date,
	order_date AS date,
	product_id
FROM dannys_diner.members
LEFT JOIN dannys_diner.sales
ON dannys_diner.members.customer_id = dannys_diner.sales.customer_id
WHERE join_date > order_date
	),
occurrence AS ( 
	SELECT *,
	ROW_NUMBER () OVER (PARTITION BY customer_id ORDER BY date desc) AS "rank"            
    FROM member_purchase
	)

SELECT occurrence.customer_id, product_name as first_purchased_item , join_date, date
FROM occurrence
LEFT JOIN dannys_diner.menu
ON occurrence.product_id = dannys_diner.menu.product_id
WHERE RANK = 1