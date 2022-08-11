'''
Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the primary key for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key for this table.
user_id is a foreign key with a reference to the Signups table.
action is an ENUM of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write an SQL query to find the confirmation rate of each user.

Return the result table in any order.

The query result format is in the following example.
'''
-- Method1: cte and union
WITH CTE AS(
    SELECT 
        user_id,
        CASE WHEN action="confirmed" then 1 else 0 end AS converted_row
    FROM Confirmations
)

SELECT CTE.user_id, round(SUM(converted_row)/count(converted_row),2) AS confirmation_rate 
FROM CTE
GROUP BY CTE.user_id

UNION

SELECT user_id,0.00 FROM Signups
WHERE user_id NOT IN (SELECT user_id FROM CTE )

--Method2: GROUPBY within CTE
WITH CTE AS(
    SELECT 
        user_id,
        ROUND(SUM(CASE WHEN action="confirmed" then 1 else 0 end)/COUNT(*),2) AS converted_row
    FROM Confirmations
    GROUP BY user_id
)

SELECT DISTINCT S.user_id, 
    IFNULL(CTE.converted_row, 0.00) AS confirmation_rate
FROM Signups S
LEFT JOIN CTE
ON S.user_id = CTE.user_id