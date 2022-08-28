'''
link: https://leetcode.com/problems/active-users/
Table: Accounts

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
This table contains the account id and the user name of each account.
 

Table: Logins

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| login_date    | date    |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

Active users are those who logged in to their accounts for five or more consecutive days.

Write an SQL query to find the id and the name of active users.

Return the result table ordered by id.
'''
-- find consecutive value
'''
1st line: You are getting the distinct id of person X
2nd line: Getting the name of that person
3rd line: Cross join between the login table (table a) and itself (table b)
4th line: You have two conditions: 1) you are matching the ids across tables 2) ensuring that the date diff between any record in table a and table b is between 1 and 4 days
5th line: Grouping by both id and date as a person can login twice a day so this no matter how many times they login a day it counts as one
6th line: Here is the most important trick in the answer IMO. Here you are ensuring that you have at least 4 distinct dates in table b that have a date diff of 1-4 days between a certain date in table a
'''
SELECT DISTINCT 
     A.id
    , (SELECT name FROM accounts WHERE id=A.id) AS name

FROM Logins A
JOIN Logins B
WHERE A.id = B.id
AND DATEDIFF(A.login_date,B.login_date) BETWEEN 1 AND 4
GROUP BY A.id, A.login_date
HAVING COUNT(DISTINCT b.login_date) = 4