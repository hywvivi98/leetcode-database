'''
link: https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  | 
| customer_id | int  |
| order_type  | int  | 
+-------------+------+
order_id is the primary key column for this table.
Each row of this table indicates the ID of an order, the ID of the customer who ordered it, and the order type.
The orders could be of type 0 or type 1.
 

Write an SQL query to report all the orders based on the following criteria:

If a customer has at least one order of type 0, do not report any order of type 1 from that customer.
Otherwise, report all the orders of the customer.
Return the result table in any order.
'''
-- Method1: reverse value of 0 and 1
-- hint: divide into two situation, use CTE and then UNION
WITH CTE AS (
SELECT 
    customer_id
    , SUM(CASE 
        WHEN order_type = 0 THEN 1
        WHEN order_type = 1 THEN 0 END) AS count0
FROM Orders
GROUP BY customer_id
HAVING count0 >= 1
)

SELECT O.order_id
    , O.customer_id
    , order_type
FROM Orders O
JOIN CTE
ON O.customer_id = CTE.customer_id
WHERE order_type != 1

UNION 

SELECT order_id
    , customer_id
    , order_type
FROM Orders
WHERE customer_id NOT IN (SELECT customer_id FROM CTE)

-- Method2: 
-- use dense_rank() to distinguish 0 and 1 
WITH CTE AS
(
SELECT 
    order_id,
    customer_id,
    order_type,
    dense_rank() over(partition by customer_id ORDER BY order_type  asc) as rnk
FROM Orders
)

SELECT  
    order_id,
    customer_id, 
    order_type
FROM CTE
WHERE rnk = 1