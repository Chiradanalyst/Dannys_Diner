/*

Which item was the most popular for each customer?

	Step 1
		- Create CTE with customer_id, product_id & count of purchase_id as purchased
		- Grouped purchased by customer_id & product_id
	Step 2
		- Query with customer_id & MAX of purchased, this is to only show the highest value for each customer as favorite_food
		- favorite_food is grouped by customer_id
		- ordered by favorite_food in DESC to show the highest value first
 
*/

WITH purchased_cte AS (
SELECT customer_id, 
		product_id,
		COUNT(product_id) AS purchased
FROM dannys_diner.sales
GROUP BY product_id, customer_id)

SELECT customer_id, MAX(purchased) as favorite_food
FROM purchased_cte
GROUP BY customer_id
ORDER BY MAX(purchased) DESC
