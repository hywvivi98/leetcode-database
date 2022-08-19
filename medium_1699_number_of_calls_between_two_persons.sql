'''
link: https://leetcode.com/problems/number-of-calls-between-two-persons/
Table: Calls

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| from_id     | int     |
| to_id       | int     |
| duration    | int     |
+-------------+---------+
This table does not have a primary key, it may contain duplicates.
This table contains the duration of a phone call between from_id and to_id.
from_id != to_id
 

Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

Return the result table in any order.
'''
-- hint: LEAST() & GREATEST() function
-- ref:https://database.guide/min-vs-least-in-mysql-whats-the-difference/
SELECT LEAST(from_id,to_id) person1
    , GREATEST(from_id,to_id) person2
    , COUNT(*) call_count
    , SUM(duration) total_duration
FROM Calls
GROUP BY 1,2 