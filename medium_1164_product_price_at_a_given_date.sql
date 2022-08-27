'''
link:https://leetcode.com/problems/product-price-at-a-given-date/
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.
'''
-- Method 1: select time range condition within CTE1 + 
-- inlcude all possible values in another cte using distinct + select values from two cte
WITH CTE AS (
SELECT DISTINCT product_id
    , new_price
    , RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC ) AS lastchange
FROM Products
WHERE change_date <= '2019-08-16'
),

CTE2 AS (
SELECT DISTINCT product_id
FROM Products
)


SELECT DISTINCT CTE2.product_id
    , IFNULL(CTE.new_price,10) AS price
FROM CTE2 
LEFT JOIN CTE
ON CTE2.product_id = CTE.product_id
AND lastchange = 1


-- Method 2: better - difference between join with ON & AND and join with on and then filter with where
-- use rank window function to select the first value given some conditions + use
WITH CTE AS (
SELECT product_id
    , new_price
    , RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC ) AS lastchange
FROM Products
WHERE change_date <= '2019-08-16'
)

SELECT DISTINCT p.product_id
    , COALESCE(CTE.new_price,10) AS price
FROM Products p 
LEFT JOIN CTE
ON p.product_id = CTE.product_id
-- instead of where, use AND as a join condition 
--  if we use where, we will directly filter out null values , whose price is supposed to be 10
AND lastchange = 1 