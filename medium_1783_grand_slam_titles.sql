'''
link: https://leetcode.com/problems/grand-slam-titles/
Table: Players

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| player_id      | int     |
| player_name    | varchar |
+----------------+---------+
player_id is the primary key for this table.
Each row in this table contains the name and the ID of a tennis player.
 

Table: Championships

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| year          | int     |
| Wimbledon     | int     |
| Fr_open       | int     |
| US_open       | int     |
| Au_open       | int     |
+---------------+---------+
year is the primary key for this table.
Each row of this table contains the IDs of the players who won one each tennis tournament of the grand slam.
 

Write an SQL query to report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.

Return the result table in any order.
'''
-- hint: union all, then group by player_id

WITH CTE AS (
SELECT year
    , Wimbledon as id
FROM Championships
UNION ALL 
SELECT year
    , Fr_open as id
FROM Championships
UNION ALL 
SELECT year
    , US_open as id
FROM Championships
UNION ALL 
SELECT year
    , Au_open as id
FROM Championships
)

SELECT DISTINCT id as player_id
    , player_name
    , COUNT(ID) AS grand_slams_count
    -- analternative way is to use window function without group by, but this will cause slowness
    -- , COUNT(id) OVER (PARTITION BY id ) AS grand_slams_count
    
FROM CTE
JOIN Players
ON CTE.id = Players.player_id
GROUP BY id