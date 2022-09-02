'''
link: https://leetcode.com/problems/number-of-times-a-driver-was-a-passenger/
Table: Rides

+--------------+------+
| Column Name  | Type |
+--------------+------+
| ride_id      | int  |
| driver_id    | int  |
| passenger_id | int  |
+--------------+------+
ride_id is the primary key for this table.
Each row of this table contains the ID of the driver and the ID of the passenger that rode in ride_id.
Note that driver_id != passenger_id.
 

Write an SQL query to report the ID of each driver and the number of times they were a passenger.

Return the result table in any order.
'''
-- Method1: left join
-- aggregrate function + left join with IFNULL() situation
WITH CTE AS (
SELECT DISTINCT passenger_id
    , COUNT(passenger_id) AS TIMES
FROM Rides
GROUP BY passenger_id)

SELECT DISTINCT R.driver_id
    , IFNULL(CTE.TIMES,0) AS cnt
FROM Rides R
LEFT JOIN CTE
ON R.driver_id = CTE.passenger_id

-- Method1: self join
select a.driver_id, ifnull(count(distinct b.ride_id),0) as cnt
from rides a
left join rides b
on a.driver_id = b.passenger_id
group by 1