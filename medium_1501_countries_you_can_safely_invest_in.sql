'''
link: https://leetcode.com/problems/countries-you-can-safely-invest-in/
Table Person:

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |
| name           | varchar |
| phone_number   | varchar |
+----------------+---------+
id is the primary key for this table.
Each row of this table contains the name of a person and their phone number.
Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the phone number (7 characters) where x and y are digits. Both can contain leading zeros.
 

Table Country:

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| name           | varchar |
| country_code   | varchar |
+----------------+---------+
country_code is the primary key for this table.
Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
 

Table Calls:

+-------------+------+
| Column Name | Type |
+-------------+------+
| caller_id   | int  |
| callee_id   | int  |
| duration    | int  |
+-------------+------+
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
 

A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call duration of the calls in this country is strictly greater than the global average call duration.

Write an SQL query to find the countries where this company can invest.

Return the result table in any order.
'''
-- # SPLIT country code from original phone number
WITH CTE AS(
SELECT id
    , name
    , LEFT(phone_number,3) AS country_code
FROM Person

),
-- # join personal information with country information 
CTE2 AS (
SELECT id
    , CTE.name
    , Country.name AS country_name
    , Country.country_code
FROM CTE
JOIN Country
ON CTE.country_code = Country.country_code
),

-- # flatten calls information in order to calculate sum of duration by different countries
CTE3 AS (
SELECT caller_id AS id
    ,  duration
FROM Calls
UNION ALL 
SELECT callee_id AS id
    ,  duration
FROM Calls
)
,
-- # average duration by country 
CTE4 AS (
SELECT CTE3.id
    , CTE2.country_name
    , AVG (CTE3.duration) AS AVE_COUNTRY
FROM CTE3
LEFT JOIN CTE2
ON CTE3.id = CTE2.id
GROUP BY CTE2.country_name)

-- # find the country whose avg duration is greater than global avg duration
SELECT DISTINCT country_name AS country
FROM CTE4
WHERE CTE4.AVE_COUNTRY > (SELECT AVG(CTE3.duration) FROM CTE3)
