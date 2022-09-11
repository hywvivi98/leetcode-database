'''
link: https://leetcode.com/problems/project-employees-iii/
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.
Each row of this table contains information about one employee.
 

Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.

Return the result table in any order.
'''
-- cte + window function 
WITH CTE AS (
SELECT P.project_id
    , P.employee_id
    , RANK() OVER (PARTITION BY P.project_id ORDER BY E.experience_years DESC) AS EMPRANK
FROM Project AS P
LEFT JOIN Employee AS E
ON P.employee_id = E.employee_id
)

SELECT project_id
    , employee_id
FROM CTE
WHERE EMPRANK=1