'''
link:https://leTable: Traffic

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| activity      | enum    |
| activity_date | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage').
 

Write an SQL query to reports for every date within at most 90 days from today, the number of users that logged in for the first time on that date. Assume today is 2019-06-30.

Return the result table in any order.

etcode.com/problems/new-users-daily-count/
Table: Traffic

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| activity      | enum    |
| activity_date | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage').
 

Write an SQL query to reports for every date within at most 90 days from today, the number of users that logged in for the first time on that date. Assume today is 2019-06-30.

Return the result table in any order.
'''
-- Method1: rank() window function + CTE + group by 
WITH CTE AS (
    -- dont' forget to add distinct 
    -- while select rank#1 and need some count() calculation --> think about duplicated situations
SELECT DISTINCT user_id
    , activity_date
    , RANK() OVER (PARTITION BY user_id,activity ORDER BY activity_date) AS FIRSTLOGIN
FROM Traffic
WHERE activity = "login"
)

SELECT activity_date AS login_date
    , COUNT( user_id) AS user_count
FROM CTE
WHERE FIRSTLOGIN=1
AND ABS(DATEDIFF("2019-06-30",activity_date))<=90
GROUP BY activity_date

-- Method2: use min() to replace rank#1
WITH CTE AS (
SELECT DISTINCT user_id
    , MIN(activity_date) OVER (PARTITION BY user_id,activity ORDER BY activity_date) AS activity_date
FROM Traffic
WHERE activity = "login"
)

SELECT activity_date AS login_date
    , COUNT( user_id) AS user_count
FROM CTE
WHERE ABS(DATEDIFF("2019-06-30",activity_date))<=90
GROUP BY activity_date