'''
link: https://leetcode.com/problems/apples-oranges/
Table: Sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_date     | date    |
| fruit         | enum    | 
| sold_num      | int     | 
+---------------+---------+
(sale_date, fruit) is the primary key for this table.
This table contains the sales of "apples" and "oranges" sold each day.
 

Write an SQL query to report the difference between the number of apples and oranges sold each day.

Return the result table ordered by sale_date.
'''

-- hint: simple inner join
SELECT A.sale_date
    , B.sold_num-A.sold_num AS diff
FROM Sales A
INNER JOIN Sales B
ON A.sale_date = B.sale_date
AND A.fruit != B.fruit
GROUP BY A.sale_date