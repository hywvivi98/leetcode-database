'''
link: https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/
Table: Logs

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| log_id        | int     |
+---------------+---------+
log_id is the primary key for this table.
Each row of this table contains the ID in a log Table.
 

Write an SQL query to find the start and end number of continuous ranges in the table Logs.

Return the result table ordered by start_id.
'''
-- hint: when asking things related to something in order -> think about rank/row_number 
WITH CTE AS (
SELECT log_id
    , log_id - RANK() OVER (ORDER BY log_id )  AS var
FROM Logs)

SELECT MIN(log_id) AS start_id
    , MAX(log_id) AS end_id
FROM CTE
GROUP BY var