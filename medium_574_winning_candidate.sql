'''
link:https://leetcode.com/problems/winning-candidate/

Table: Candidate
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
+-------------+----------+
id is the primary key column for this table.
Each row of this table contains information about the id and the name of a candidate.
 

Table: Vote
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| candidateId | int  |
+-------------+------+
id is an auto-increment primary key.
candidateId is a foreign key to id from the Candidate table.
Each row of this table determines the candidate who got the ith vote in the elections.
 

Write an SQL query to report the name of the winning candidate (i.e., the candidate who got the largest number of votes).

The test cases are generated so that exactly one candidate wins the elections.
'''
-- Method1: cte + join
WITH CTE AS (
SELECT V.id
    , V.candidateId
    , C.name
    , COUNT(name) OVER (PARTITION BY name) AS votes
FROM Vote V
LEFT JOIN Candidate C
ON V.candidateId = C.id
ORDER BY votes DESC
)

SELECT name 
FROM CTE
LIMIT 1

-- Method2: temp table + join
SELECT
    name AS 'Name'
FROM
    Candidate
        JOIN
    (SELECT
        Candidateid
    FROM
        Vote
    GROUP BY Candidateid
    ORDER BY COUNT(*) DESC
    LIMIT 1) AS winner
WHERE
    Candidate.id = winner.Candidateid
;