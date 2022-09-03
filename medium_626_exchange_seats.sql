'''
link: https://leetcode.com/problems/exchange-seats/
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 

Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.
'''
-- Method1: condition in telling the last row + mixed useage of if and case when
SELECT 
IF(id < (SELECT MAX(id) FROM Seat), 
          CASE WHEN id%2 != 0 THEN id+1 ELSE id-1 END  
          ,CASE WHEN id%2 != 0 THEN id ELSE id-1 END) AS id   
    , student
FROM Seat
ORDER BY id

-- Method2: order first, then use ROW_NUMBER() window function 
-- It doesn't matter whether the last row is odd or not 
SELECT
ROW_NUMBER() OVER(order by IF(MOD(id, 2) = 0, id-1, id+1) ) as id,
student
FROM seat