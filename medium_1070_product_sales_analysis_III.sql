'''
link: https://leetcode.com/problems/product-sales-analysis-iii/
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key of this table.
product_id is a foreign key to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the product name of each product.
 

Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

Return the resulting table in any order.
'''
-- Method1: CTE + window function
WITH CTE AS (
SELECT product_id
    , year
    , quantity
    , price
    , RANK() OVER (PARTITION BY product_id ORDER BY year ) AS FIRSTYEAR
FROM Sales)

SELECT product_id
    , year AS first_year
    , quantity
    , price
FROM CTE 
WHERE FIRSTYEAR =1

-- Method2: subquery
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (
SELECT product_id, MIN(year) as year
FROM Sales
GROUP BY product_id)