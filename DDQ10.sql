/*
In the first week after a customer joins the program 
(including their join date) they earn 2x points on all items,
not just sushi 
- how many points do customer A and B have at the end of January?

	- Joined the sales & members table on customer_id
	- Used the WHERE function to remove all dates before members joined
	- Removed all dates after January by adding on to the WHERE function
	- All sales happened within one week of members joining in January
	- Summed all points grouping by customer_ID
	- Ordered the points in DESC order
*/
SELECT dannys_diner.members.customer_id,
	SUM(product_id) * 20 AS points
FROM dannys_diner.members
INNER JOIN dannys_diner.sales
ON dannys_diner.members.customer_id = dannys_diner.sales.customer_id
WHERE join_date <= order_date AND order_date <= '2021-1-31'
GROUP BY dannys_diner.members.customer_id
ORDER BY points DESC