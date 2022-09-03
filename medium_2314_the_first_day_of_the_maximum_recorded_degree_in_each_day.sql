'''
link: https://leetcode.com/problems/the-first-day-of-the-maximum-recorded-degree-in-each-city/
Table: Weather

+-------------+------+
| Column Name | Type |
+-------------+------+
| city_id     | int  |
| day         | date |
| degree      | int  |
+-------------+------+
(city_id, day) is the primary key for this table.
Each row in this table contains the degree of the weather of a city on a certain day.
All the degrees are recorded in the year 2022.
 

Write an SQL query to report the day that has the maximum recorded degree in each city. If the maximum degree was recorded for the same city multiple times, return the earliest day among them.

Return the result table ordered by city_id in ascending order.
'''
-- same as Q1112
WITH CTE AS (
SELECT city_id
    , day
    , degree
    , RANK() OVER (PARTITION BY city_id ORDER BY degree DESC, day) AS CITYRANK
FROM Weather)

SELECT city_id
    , day
    , degree
FROM CTE
WHERE CITYRANK =1