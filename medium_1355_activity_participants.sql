'''
link: https://leetcode.com/problems/activity-participants/
Table: Friends

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
| activity      | varchar |
+---------------+---------+
id is the id of the friend and primary key for this table.
name is the name of the friend.
activity is the name of the activity which the friend takes part in.
 

Table: Activities

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
name is the name of the activity.
 

Write an SQL query to find the names of all the activities with neither the maximum nor the minimum number of participants.

Each activity in the Activities table is performed by any person in the table Friends.

Return the result table in any order.

'''
-- use multiple subquery(cte)
WITH CTE AS (
SELECT COUNT(activity) AS ACTCOUNT
    , activity
FROM Friends 
GROUP BY activity)
,
CTE2 AS(
SELECT activity 
FROM CTE
WHERE ACTCOUNT = (SELECT MAX(ACTCOUNT) FROM CTE)
UNION ALL
SELECT activity 
FROM CTE
WHERE ACTCOUNT = (SELECT MIN(ACTCOUNT) FROM CTE)
)

SELECT name AS activity
FROM Activities
WHERE name NOT IN (SELECT activity FROM CTE2)

-- Method2: window function
WITH CTE AS (
SELECT activity
    , RANK() OVER ( ORDER BY COUNT(activity)) AS ASEORDER
    , RANK() OVER ( ORDER BY COUNT(activity) DESC) AS DESCORDER
FROM Friends
GROUP BY activity)

SELECT name AS activity
FROM Activities
WHERE name IN (SELECT activity 
                FROM CTE
                WHERE ASEORDER!=1 AND DESCORDER!=1)