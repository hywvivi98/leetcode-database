'''
link: https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/
Table: Customers

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| customer_id         | int     |
| customer_name       | varchar |
+---------------------+---------+
customer_id is the primary key for this table.
customer_name is the name of the customer.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| customer_id   | int     |
| product_name  | varchar |
+---------------+---------+
order_id is the primary key for this table.
customer_id is the id of the customer who bought the product "product_name".
 

Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them to purchase this product.

Return the result table ordered by customer_id.
'''
-- Method1: group by + having
SELECT a.customer_id, a.customer_name
FROM customers a , orders b
WHERE a.customer_id  = b.customer_id
GROUP BY a.customer_id
HAVING SUM(b.product_name="A") >0 
    AND SUM(b.product_name="B") > 0 
    AND SUM(b.product_name="C")=0

-- Method 2: simple where selection 
select distinct o.customer_id, c.customer_name
from orders as o left join customers as c
  on o.customer_id = c.customer_id
where (o.customer_id, 'A') in (select customer_id, product_name from orders)
  and (o.customer_id, 'B') in (select customer_id, product_name from orders)
  and (o.customer_id, 'C') not in (select customer_id, product_name from orders)
