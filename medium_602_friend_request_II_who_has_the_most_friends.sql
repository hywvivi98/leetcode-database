'''
link: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write an SQL query to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.
'''
-- UNION ALL + aggregate function 
WITH CTE AS (
SELECT requester_id AS id
FROM RequestAccepted
UNION ALL 
SELECT accepter_id AS id
FROM RequestAccepted
)

SELECT id
    , COUNT(id) AS num
FROM CTE 
GROUP BY id
ORDER BY num DESC
LIMIT 1