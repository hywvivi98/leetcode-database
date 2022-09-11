'''
link: https://leetcode.com/problems/team-scores-in-football-tournament/
Table: Teams

+---------------+----------+
| Column Name   | Type     |
+---------------+----------+
| team_id       | int      |
| team_name     | varchar  |
+---------------+----------+
team_id is the primary key of this table.
Each row of this table represents a single football team.
 

Table: Matches

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| match_id      | int     |
| host_team     | int     |
| guest_team    | int     | 
| host_goals    | int     |
| guest_goals   | int     |
+---------------+---------+
match_id is the primary key of this table.
Each row is a record of a finished match between two different teams. 
Teams host_team and guest_team are represented by their IDs in the Teams table (team_id), and they scored host_goals and guest_goals goals, respectively.
 

You would like to compute the scores of all teams after all matches. Points are awarded as follows:
A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team).
Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches.

Return the result table ordered by num_points in decreasing order. In case of a tie, order the records by team_id in increasing order.

'''
-- Method1: easy to read and understand => CASE WHEN + UNION + GROUP BY 
WITH CTE AS (
SELECT *
    , CASE WHEN host_goals > guest_goals THEN 3
            WHEN host_goals = guest_goals THEN 1
            WHEN host_goals < guest_goals THEN 0 END AS host_pts
    , CASE WHEN host_goals < guest_goals THEN 3
            WHEN host_goals = guest_goals THEN 1
            WHEN host_goals > guest_goals THEN 0 END AS guest_pts
FROM Matches
)
,
CTE2 AS (
SELECT host_team AS team_id
    , host_pts AS num_points
FROM CTE
UNION ALL
SELECT guest_team AS team_id
    , guest_pts AS num_points
FROM CTE
-- be careful: don't need to use unnecessary group by () here, because we want to keep all values
-- GROUP BY team_id
)

SELECT Teams.team_id
    , Teams.team_name
    , IFNULL(SUM(num_points),0) AS num_points
FROM CTE2
RIGHT JOIN Teams
ON Teams.team_id = CTE2.team_id
GROUP BY Teams.team_id
ORDER BY num_points DESC, team_id

-- Method2: LEFT JOIN, without UNION
-- the trick is to use OR condition whiling joining 
SELECT team_id, team_name,
SUM(
    CASE WHEN team_id = host_team AND host_goals > guest_goals THEN 3
         WHEN team_id = guest_team AND guest_goals > host_goals THEN 3
         WHEN host_goals = guest_goals THEN 1
         ELSE 0
    END          
) AS "num_points"
FROM Teams t
LEFT JOIN Matches m ON t.team_id = m.host_team OR t.team_id = m.guest_team
GROUP BY team_id, team_name
ORDER BY num_points DESC, team_id