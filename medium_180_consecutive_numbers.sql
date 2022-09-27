'''
link: https://leetcode.com/problems/consecutive-numbers/

Table: Logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
id is an autoincrement column.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.
'''
-- hint: use LEAD() window function twice
WITH CTE AS (
SELECT num
     , LEAD(num,1) OVER () as D1
     , LEAD(num,2) OVER () as D2
FROM Logs
)


SELECT DISTINCT num AS ConsecutiveNums
FROM CTE
WHERE num = D1 
AND num = D2


-- Method2: group by and having count()
select distinct num as ConsecutiveNums from
(select num, id - row_number() over (order by num, id) rank from logs) a
group by num,rank
having count(*) >2