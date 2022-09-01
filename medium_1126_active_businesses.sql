'''
link:https://leetcode.com/problems/active-businesses/
Table: Events

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |
| event_type    | varchar |
| occurences    | int     | 
+---------------+---------+
(business_id, event_type) is the primary key of this table.
Each row in the table logs the info that an event of some type occurred at some business for a number of times.
 

The average activity for a particular event_type is the average occurences across all companies that have this event.

An active business is a business that has more than one event_type such that their occurences is strictly greater than the average activity for that event.

Write an SQL query to find all active businesses.

Return the result table in any order.
'''
-- Mththod1: window function + cte 
-- Notes!!: use case of single partition by!!
-- since business_id itself is not primary key, and we need to group by business_id further
-- we must use window function (instead of group by) to keep all records of business_id 
-- (note that the number of rows and the value of business_id produced with these two different methods are different)
WITH CTE AS (
SELECT business_id
    , event_type
    , occurences
    , AVG(occurences) OVER (PARTITION BY event_type)  AS avd_activity
FROM Events
 )
-- If we want to use group by within the window function, we must use left join method to keep all records of business_id
SELECT business_id
FROM CTE 
WHERE occurences > avd_activity
GROUP BY business_id
HAVING COUNT(business_id) >1

-- Method2: subquery +left join 
SELECT business_id
FROM Events AS a
LEFT JOIN 
    (
    SELECT event_type, AVG(occurences) AS av
    FROM Events
    GROUP BY event_type
    ) AS b
ON a.event_type = b.event_type
WHERE a.occurences > b.av
GROUP BY business_id
HAVING COUNT(*)>1