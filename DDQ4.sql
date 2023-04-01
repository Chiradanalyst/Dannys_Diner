/*
What is the most purchased item on the menu and how many times was it 
purchased by all customers?

		- Left Join the menu & sales tables using product_id
		- Query product_name 
		- Query product_id with a COUNT function as times_purchased
		- Order by times_purchased DESC to place the highest value first
		- Limit 1 only to show the top value
*/

SELECT product_name ,
	COUNT(sales.product_id) AS times_purchased
FROM dannys_diner.sales
LEFT JOIN dannys_diner.menu
ON dannys_diner.sales.product_id = dannys_diner.menu.product_id
GROUP BY product_name
ORDER BY times_purchased DESC
LIMIT 1