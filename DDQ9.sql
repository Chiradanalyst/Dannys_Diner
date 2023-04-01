/*

If each $1 spent equates to 10 points and sushi has a 2x points multiplier
- how many points would each customer have?

	Sept 1
		- Create sushi CTE
			- Sushi alone is worth 20 points per 1$ so I want to single it out
			- LEFT JOIN sales & menu on product_id
			- Use the WHERE function to single out sushi
			- SUM(price)*20 as points 
				- this is to sum the total spent, then multiply it by 20 and give me the points I need
			- Finally, I GROUPED BY customer_id
		Step 2
			- Create second CTE not_sushi
			- I want to get the total spent for all products that are not sushi and multiply it by 10
			- LEFT JOIN sales & menu on product_id
			- Use the WHERE function to get all products that are not sushi
			- SUM(price)*10 as points 
				- this is to sum the total spent, then multiply it by 10 and give me the points I need
			- Finally, I GROUPED BY customer_id
		Step 3
			- Create total_points CTE
			- Union with sushi & not sushi CTEs
		Step 4
			- Queried customer_id & SUM(points) as points
			- Grouped by customer_id
			- ordered by points DESC
			
*/
WITH sushi AS (
SELECT customer_id,
	SUM(menu.price)*20 AS points
FROM dannys_diner.sales
LEFT JOIN dannys_diner.menu
ON dannys_diner.sales.product_id = dannys_diner.menu.product_id
WHERE menu.product_name = 'sushi'
GROUP BY customer_id),

not_sushi AS (
SELECT customer_id,
	SUM(menu.price)*10 AS points
FROM dannys_diner.sales
INNER JOIN dannys_diner.menu
ON dannys_diner.sales.product_id = dannys_diner.menu.product_id
WHERE menu.product_name != 'sushi'
GROUP BY customer_id
),
total_points AS(
SELECT * 
	FROM not_sushi
	
UNION
	
SELECT * 
	FROM sushi)

Select customer_id,
SUM(points) AS points
FROM total_points
GROUP BY customer_id
ORDER BY points DESC