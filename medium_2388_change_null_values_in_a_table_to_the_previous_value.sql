'''
link:https://leetcode.com/problems/change-null-values-in-a-table-to-the-previous-value/
Table: CoffeeShop

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| drink       | varchar |
+-------------+---------+
id is the primary key for this table.
Each row in this table shows the order id and the name of the drink ordered. Some drink rows are nulls.
 

Write an SQL query to replace the null values of drink with the name of the drink of the previous row that is not null. It is guaranteed that the drink of the first row of the table is not null.

Return the result table in the same order as the input.
'''
-- hint: use ROW_NUMBER() to initialize and keep row order
-- , use SUM(1-ISNULL()) to classify into different groups based on if it has a null value
WITH cte AS 
(SELECT id
    , drink
    , ROW_NUMBER() OVER () AS nb 
 FROM CoffeeShop
), -- nb = initial row order

cte2 AS 
(SELECT id
    , drink
    , nb
    , SUM(1-ISNULL(drink)) OVER (ORDER BY nb) AS group_id 
    -- alternatively, use count to form group
    -- , COUNT(drink) OVER (ORDER BY nb) AS group_id
FROM cte
) -- same group_id -> same drink

SELECT  id
    , FIRST_VALUE(drink) OVER (PARTITION BY group_id) AS drink
FROM cte2