'''
link:https://leetcode.com/problems/rising-temperature/
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 

Write an SQL query to find all dates Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.
'''
SELECT A.id
FROM Weather A
JOIN Weather B
ON A.temperature > B.temperature
-- dateA is one day after dateB
AND DATEDIFF(A.recordDate, B.recordDate)=1