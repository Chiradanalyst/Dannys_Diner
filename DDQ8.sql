/*

What is the total items and amount spent for each member before they 
became a member?
	
	Step 1
		- Create CTE member_purchase
			- LEFT JOIN sales & members table on customer_id
			- use WHERE function to filter for the dates before the customers joined
			- queried customer_id as c_id, join date, order_date as date & product_id
	Step 2
	- Queried c_id, COUNT(product_id) as times_purchased to count the products purchased
	- Queried SUM(price) as total_spent_before_joining to sum the total amount customers spent
	- In the main query, joined menu and member purchase to add the price
	- Grouped by customer_id(C_ID)

*/

WITH member_purchase AS (
SELECT members.customer_id as c_id,
	join_date,
	order_date AS date,
	product_id
FROM dannys_diner.members
LEFT JOIN dannys_diner.sales
ON dannys_diner.members.customer_id = dannys_diner.sales.customer_id
WHERE join_date > order_date
	)
SELECT c_id, 
	COUNT(member_purchase.product_id) as purchased_items,
	SUM(price) AS total_spent_before_joining
FROM member_purchase
LEFT JOIN dannys_diner.menu
ON dannys_diner.menu.product_id = member_purchase.product_id
GROUP BY c_id


