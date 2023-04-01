/*
How many days has each customer visited the restaurant?
	Step 1 
		- Queried data with customer_id & order_date
			- combined a count & distinct with order_date & named this Days_visited
			- this singles out the distinct dates customers came in and counts those days
			
		- Grouped days_visited by customer_id
*/

Select customer_id,
	COUNT(DISTINCT(order_date)) as days_visited
FROM Dannys_Diner.sales
GROUP BY customer_id