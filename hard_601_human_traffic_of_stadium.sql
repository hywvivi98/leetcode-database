'''
link:https://leetcode.com/problems/human-traffic-of-stadium/
Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the primary key for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 

Write an SQL query to display the records with three or more rows with consecutive ids, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.
'''
-- Method1: Window function + group by 
-- notice when to use partition by and when to use group by 
WITH CTE AS (
SELECT *
, id - ROW_NUMBER() OVER (ORDER BY id ) AS A
FROM stadium
WHERE people >= 100)

SELECT id
    , visit_date
    , people
FROM CTE
WHERE A IN (
            -- only returns the difference that will be selected from 
            SELECT A
            FROM CTE
            GROUP BY A
            HAVING COUNT(A)>=3
            )

-- Method2: another way to use window function, more complicated 
with q1 as (
select id, id - row_number() over() as id_diff
from stadium
where people > 99
),
q2 as (
select *, row_number() over(partition by id_diff) as id_diff_order
from q1
),
q3 as (
select id
from q2
where id_diff in (select id_diff from q2 where id_diff_order > 2 group by id_diff)
)
select *
from stadium
where id in (select id from q3)
order by visit_date

-- Method3: use preceding function 
with q1 as (
select *, 
     count(*) over( order by id range between current row and 2 following ) following_cnt,
     count(*) over( order by id range between 2 preceding and current row ) preceding_cnt,
     count(*) over( order by id range between 1 preceding and 1 following ) current_cnt
from stadium
where people > 99
)
select id, visit_date, people
from q1
where following_cnt = 3 or preceding_cnt = 3 or current_cnt = 3
order by visit_date