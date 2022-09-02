'''
link: https://leetcode.com/problems/customers-who-bought-all-products/
Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
There is no primary key for this table. It may contain duplicates.
product_key is a foreign key to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key column for this table.
 

Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.
'''
-- hint: foreign key restriction -> Since 'product_key' in Customer table is the foreign key to product table, 
-- all 'product_key' shown in Customer table must exist in Product table
SELECT customer_id
FROM Customer
GROUP BY customer_id
-- Notes: since product_key is foreign key, we can directly use = to match the key from both tables
HAVING COUNT( DISTINCT product_key is ) = (SELECT COUNT(*) FROM Product)