'''
link:https://leetcode.com/problems/weather-type-in-each-country/
able: Countries

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| country_id    | int     |
| country_name  | varchar |
+---------------+---------+
country_id is the primary key for this table.
Each row of this table contains the ID and the name of one country.
 

Table: Weather

+---------------+------+
| Column Name   | Type |
+---------------+------+
| country_id    | int  |
| weather_state | int  |
| day           | date |
+---------------+------+
(country_id, day) is the primary key for this table.
Each row of this table indicates the weather state in a country for one day.
 

Write an SQL query to find the type of weather in each country for November 2019.

The type of weather is:

Cold if the average weather_state is less than or equal 15,
Hot if the average weather_state is greater than or equal to 25, and
Warm otherwise.
Return result table in any order.
'''
-- Method1: avg window function
WITH CTE AS (
SELECT country_id
, CASE WHEN AVG(weather_state) OVER (PARTITION BY country_id) <= 15 THEN "Cold"
        WHEN AVG(weather_state) OVER (PARTITION BY country_id) >= 25 THEN "Hot"
        WHEN  AVG(weather_state) OVER (PARTITION BY country_id) BETWEEN 15 AND 25 THEN "Warm" END AS weather_type
FROM Weather
WHERE MONTH(day)=11 AND YEAR(day)=2019
    )
    
SELECT DISTINCT C.country_name
    , CTE.weather_type
FROM Countries C
JOIN CTE
ON CTE.country_id = C.country_id

-- Method2: simple group by 
SELECT a.country_name,
CASE WHEN AVG(weather_state)<=15 THEN "Cold"
WHEN AVG(weather_state)>=25 THEN "Hot"
ELSE "Warm" END as weather_type FROM Countries as a
JOIN Weather as b
ON a.country_id=b.country_id
WHERE b.day BETWEEN "2019-11-01" AND "2019-11-30"
GROUP BY a.country_id;