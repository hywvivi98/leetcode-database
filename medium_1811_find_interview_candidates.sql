'''
link:https://leetcode.com/problems/find-interview-candidates/
Table: Contests

+--------------+------+
| Column Name  | Type |
+--------------+------+
| contest_id   | int  |
| gold_medal   | int  |
| silver_medal | int  |
| bronze_medal | int  |
+--------------+------+
contest_id is the primary key for this table.
This table contains the LeetCode contest ID and the user IDs of the gold, silver, and bronze medalists.
It is guaranteed that any consecutive contests have consecutive IDs and that no ID is skipped.
 

Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| mail        | varchar |
| name        | varchar |
+-------------+---------+
user_id is the primary key for this table.
This table contains information about the users.
 

Write an SQL query to report the name and the mail of all interview candidates. A user is an interview candidate if at least one of these two conditions is true:

The user won any medal in three or more consecutive contests.
The user won the gold medal in three or more different contests (not necessarily consecutive).
Return the result table in any order.
'''
-- First melt contest into long format, then rank the medal by contest_id within each user group.
-- Here the consecutive medal won means the difference between rank and contest_id are the same.
-- Next, filter the result by selecting those who has # within difference group >= N，and combine them with gold medal winners.
-- Finally join user table and keep the distinct results.

WITH CTE AS (
SELECT contest_id
    , gold_medal AS user_id
FROM Contests
UNION ALL 
SELECT contest_id
    , silver_medal AS user_id
FROM Contests
UNION ALL 
SELECT contest_id
    , bronze_medal AS user_id
FROM Contests
),

CTE2 AS(
SELECT contest_id
    , user_id
    , ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY contest_id) AS RN
FROM CTE
ORDER BY RN,contest_id),

CTE3 AS (
SELECT contest_id
    , user_id 
FROM CTE2
GROUP BY user_id, contest_id-RN
HAVING COUNT(*) >= 3 
UNION ALL 
SELECT contest_id
    , gold_medal AS user_id
FROM Contests
GROUP BY gold_medal
HAVING COUNT(gold_medal) >= 3)

SELECT DISTINCT name
    , mail 
FROM Users U
JOIN CTE3
ON CTE3.user_id = U.user_id

-- Method2: self join
SELECT u.name, u.mail
FROM Contests c, Users u
WHERE u.user_id = c.gold_medal
GROUP BY u.user_id
HAVING COUNT(contest_id)>=3 

UNION 

SELECT  u.name, u.mail
FROM Users u , Contests c1 , Contests c2, Contests c3
WHERE u.user_id IN  (c1.gold_medal, c1.silver_medal, c1.bronze_medal)
      AND u.user_id IN  (c2.gold_medal, c2.silver_medal, c2.bronze_medal)
      AND u.user_id IN  (c3.gold_medal, c3.silver_medal, c3.bronze_medal)
      AND c1.contest_id-1 = c2.contest_id AND c2.contest_id-1 = c3.contest_id