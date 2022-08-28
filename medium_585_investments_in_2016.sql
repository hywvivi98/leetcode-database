'''
link:https://leetcode.com/problems/investments-in-2016/
Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key column for this table.
Each row of this table contains information about one policy where:
pid is the policyholders policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holders city.
lon is the longitude of the policy holders city.
 

Write an SQL query to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city like any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.
'''
-- use HAVING COUNT() to select non-unique values
WITH CTE1 AS(
SELECT pid
    , lat
    , lon
FROM Insurance
GROUP BY lat, lon
HAVING COUNT(*)=1
),

CTE2 AS (
SELECT pid
    , tiv_2015
FROM Insurance
GROUP BY tiv_2015
HAVING COUNT(*)>=2

)

SELECT ROUND(SUM(I.tiv_2016),2) AS tiv_2016
FROM Insurance I
WHERE I.tiv_2015 IN (SELECT tiv_2015 FROM CTE2)
AND (I.lat,I.lon) IN (SELECT lat, lon FROM CTE1)

-- Method 2: use CONCAT() to create "uniqueness"
SELECT
    SUM(insurance.TIV_2016) AS TIV_2016
FROM
    insurance
WHERE
    insurance.TIV_2015 IN
    (
      SELECT
        TIV_2015
      FROM
        insurance
      GROUP BY TIV_2015
      HAVING COUNT(*) > 1
    )
    AND CONCAT(LAT, LON) IN
    (
      SELECT
        CONCAT(LAT, LON)
      FROM
        insurance
      GROUP BY LAT , LON
      HAVING COUNT(*) = 1
    )