/*
What is the total amount each customer spent at the restaurant?

	- Step 1 get product prices:
		     Left joined Sales & Menu
	- Step 2 
		Created a CTE with joined data from Step 1
	- Step 3 
		Aggregated data with a SUM function grouping by customer ID
	- Step 4 
		Converted INT into a currency 
*/

WITH Customer_Orders AS (SELECT customer_id, 
	dannys_diner.sales.product_id, 
	dannys_diner.menu.price AS spent
FROM dannys_diner.sales
LEFT JOIN dannys_diner.menu
ON dannys_diner.sales.product_id = dannys_diner.menu.product_id)

SELECT customer_id,
	CAST(SUM(spent) AS Money) AS "total_spent"
FROM Customer_Orders
Group BY customer_id
ORDER BY total_spent DESC