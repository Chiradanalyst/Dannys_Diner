/*
What was the first item from the menu purchased by each customer?
	Step 1
		- queried customer_id
		- queried order_date with a MIN function to filter for the earliest date
		- named order date as first_purchase_date
		- grouped by customer_id
*/

SELECT customer_id, MIN(order_date) as first_purchase_date
FROM dannys_diner.sales
GROUP BY customer_id
