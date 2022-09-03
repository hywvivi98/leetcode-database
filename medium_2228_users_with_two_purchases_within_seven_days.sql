'''
link: https://leetcode.com/problems/users-with-two-purchases-within-seven-days/
Table: Purchases

+---------------+------+
| Column Name   | Type |
+---------------+------+
| purchase_id   | int  |
| user_id       | int  |
| purchase_date | date |
+---------------+------+
purchase_id is the primary key for this table.
This table contains logs of the dates that users purchased from a certain retailer.
 

Write an SQL query to report the IDs of the users that made any two purchases at most 7 days apart.

Return the result table ordered by user_id.
'''
-- Method1: self-join + datediff() + groupby + having (faster)
SELECT  A.user_id
FROM Purchases A
JOIN Purchases B
ON A.user_id = B.user_id 
AND A.purchase_id != B.purchase_id 
WHERE ABS(DATEDIFF(A.purchase_date, B.purchase_date)) <=7
GROUP BY A.user_id
HAVING COUNT(*) >=2
ORDER BY user_id

-- Method2: CTE + LAG() window function
WITH CTE AS
(
SELECT
    user_id,
    purchase_date,
    Lag(purchase_date) OVER(PARTITION BY user_id ORDER BY purchase_date) AS nextDate
FROM Purchases
)

SELECT
     user_id
FROM CTE
WHERE DATEDIFF(purchase_date,nextDate) <=7
GROUP BY user_id
HAVING COUNT(user_id) <=2