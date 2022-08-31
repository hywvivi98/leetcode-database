'''
link: https://leetcode.com/problems/immediate-food-delivery-ii/
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customers preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write an SQL query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
'''
-- Method1: find rank window function to find FIRSTORDER, case when to find ordertype, then calculate average
WITH CTE AS (

SELECT customer_id
    , delivery_id
    , RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS FIRSTORDER
    , CASE WHEN order_date = customer_pref_delivery_date THEN "immediate"
            WHEN order_date != customer_pref_delivery_date THEN  "scheduled" 
            END AS ordertype
FROM Delivery
)
-- don't use sum(case when <con1> then 1 else 0 end)/count(*) to calculate average, use acd() function directly 
SELECT ROUND(AVG(ordertype="immediate")*100,2) AS immediate_percentage
FROM CTE
WHERE FIRSTORDER=1

-- Method2: use mindate to find FIRSTORDER, use subquery to primary key pair to filter conditions
SELECT 
	round(avg(order_date = customer_pref_delivery_date)*100, 2) 'immediate_percentage'
FROM 
	Delivery
WHERE 
	(customer_id, order_date) IN 
    (SELECT customer_id, min(order_date) FROM Delivery GROUP BY customer_id)

