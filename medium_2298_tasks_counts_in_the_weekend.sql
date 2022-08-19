'''
link:https://leetcode.com/problems/tasks-count-in-the-weekend/
Table: Tasks

+-------------+------+
| Column Name | Type |
+-------------+------+
| task_id     | int  |
| assignee_id | int  |
| submit_date | date |
+-------------+------+
task_id is the primary key for this table.
Each row in this table contains the ID of a task, the id of the assignee, and the submission date.
 

Write an SQL query to report:

the number of the tasks that were submitted during the weekend (Saturday, Sunday) as weekend_cnt, and
the number of the tasks that were submitted during the working days as working_cnt.
Return the result table in any order.
'''
-- hint: use DAYOFWEEK() method
SELECT SUM(CASE WHEN DAYOFWEEK(submit_date)=1 OR DAYOFWEEK(submit_date)=7 THEN 1 END) weekend_cnt
    , SUM(CASE WHEN DAYOFWEEK(submit_date)=1 OR DAYOFWEEK(submit_date)=7 THEN 0 ELSE 1 END) working_cnt
FROM Tasks