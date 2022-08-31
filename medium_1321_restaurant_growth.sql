'''
link:https://leetcode.com/problems/restaurant-growth/
Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Write an SQL query to compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return result table ordered by visited_on in ascending order.
'''
-- Calculate rolling sum

-- Method1: use window function 
-- ref1: https://joshuaotwell.com/rolling-sum-and-average-with-window-functions-in-mysql/
-- ref2: https://joshuaotwell.com/rows-and-range-windowing-clause-defaults-learning-by-example-in-mysql/
SELECT visited_on
-- the inner sum() is the sum-up amount group by each date of visited_on; while the outer sum() is the sum-up amount for each rowling seven-days window
    , SUM(SUM(amount)) OVER (ORDER BY visited_on RANGE BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount
    , ROUND(SUM(SUM(amount)) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)/7,2) AS average_amount

FROM Customer
GROUP BY visited_on
LIMIT 100000 OFFSET 6 


-- Method2: aggregrate function and group by 
WITH CTE AS (
SELECT visited_on
    , SUM(amount) AS SUMAMOUNT
FROM Customer
GROUP BY visited_on
)

SELECT C1.visited_on
-- because we are groupingby c1, SUM(C1.SUMAMOUNT) will return n*SUM(c1.amount),
-- while SUM(C2.SUMAMOUNT) will return sum-up amount for each rowling n-days window
    , SUM(C2.SUMAMOUNT) AS amount
    , ROUND(SUM(C2.SUMAMOUNT)/7,2) AS average_amount
FROM CTE C1
LEFT JOIN CTE C2
ON DATEDIFF(C1.visited_on,C2.visited_on) <=6 AND DATEDIFF(C1.visited_on,C2.visited_on) >=0
GROUP BY C1.visited_on
HAVING COUNT(*)=7
