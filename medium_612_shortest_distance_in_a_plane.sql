'''
link: https://leetcode.com/problems/shortest-distance-in-a-plane/
Table: Point2D

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
+-------------+------+
(x, y) is the primary key column for this table.
Each row of this table indicates the position of a point on the X-Y plane.
 

The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).

Write an SQL query to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.
'''
-- Method 1
-- self join, then use 1.x!= T2.x OR T1.y!= T2.y to avoid calculating the distance of a point with itself
SELECT 
    -- #   T1.x
    -- # , T1.y
    -- # , T2.x
    -- # , T2.y
     ROUND(SQRT(POW(T1.x-T2.x,2)+POW(T1.y-T2.y,2)),2) AS shortest
FROM Point2D T1
JOIN Point2D T2
-- The condition 'p1.x != p2.x OR p2.y != p2.y' is to avoid calculating the distance of a point with itself. 
-- Otherwise, the minimum distance will be always zero.
ON T1.x!= T2.x
OR T1.y!= T2.y
ORDER BY shortest
LIMIT 1

-- Method 2: use (T1.x,T1.y)!=(T2.x,T2.y) to replace T1.x!= T2.x OR T1.y!= T2.y, since (x, y) is the primary key
SELECT 
    -- #   T1.x
    -- # , T1.y
    -- # , T2.x
    -- # , T2.y
     ROUND(SQRT(POW(T1.x-T2.x,2)+POW(T1.y-T2.y,2)),2) AS shortest
FROM Point2D T1
JOIN Point2D T2
WHERE (T1.x,T1.y)!=(T2.x,T2.y)
ORDER BY shortest
LIMIT 1

-- Method 3: use min() to replace order by 
SELECT ROUND(SQRT(MIN(POW(a.x-b.x,2)+POW(a.y-b.y,2))),2) shortest
FROM Point2D a, Point2D b
WHERE (a.x,a.y)!=(b.x,b.y)
