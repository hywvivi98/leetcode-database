'''
link:https://leetcode.com/problems/product-sales-analysis-iv/
Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| user_id     | int   |
| quantity    | int   |
+-------------+-------+
sale_id is the primary key of this table.
product_id is a foreign key to Product table.
Each row of this table shows the ID of the product and the quantity purchased by a user.
Table: Product

+-------------+------+
| Column Name | Type |
+-------------+------+
| product_id  | int  |
| price       | int  |
+-------------+------+
product_id is the primary key of this table.
Each row of this table indicates the price of each product.
Write an SQL query that reports for each user the product id on which the user spent the most money. In case the same user spent the most money on two or more products, report all of them.

Return the resulting table in any order.
'''
-- Method1: CTE + RANK() 
WITH CTE AS (
SELECT S.user_id
    , S.product_id
    , SUM(S.quantity * P.price) AS TOTALSPEND
    -- SUM(S.quantity * P.price) OVER (PARTITION BY user_id, product_id ) AS TOTALSPEND 
FROM Sales AS S
JOIN Product AS P
ON S.product_id = P.product_id
GROUP BY user_id, product_id)
,

CTE2 AS (
SELECT user_id
    , product_id
    , RANK() OVER (PARTITION BY user_id ORDER BY TOTALSPEND DESC) AS RANKSPEND
FROM CTE)

SELECT user_id
    , product_id
FROM CTE2
WHERE RANKSPEND =1


-- Method2: subquery 
SELECT user_id, product_id
FROM
    (SELECT s.user_id
        , product_id
        , RANK() OVER (PARTITION BY user_id ORDER BY p.price*s.quantity DESC) rnk
    FROM 
        (SELECT user_id
            , product_id
            , SUM(quantity) quantity 
        FROM Sales GROUP BY user_id, product_id ) s
        JOIN Product p 
        USING(product_id)) temp
WHERE rnk = 1