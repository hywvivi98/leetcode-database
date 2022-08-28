'''
link:https://leetcode.com/problems/all-people-report-to-the-given-manager/
Table: Employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | int     |
| employee_name | varchar |
| manager_id    | int     |
+---------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates that the employee with ID employee_id and name employee_name reports his work to his/her direct manager with manager_id
The head of the company is the employee with employee_id = 1.
 

Write an SQL query to find employee_id of all employees that directly or indirectly report their work to the head of the company.

The indirect relation between managers will not exceed three managers as the company is small.

Return the result table in any order.
'''
-- use layers of CTE and then UNION 
WITH DIRECT AS (
SELECT employee_id 
FROM Employees
WHERE manager_id = 1 AND employee_id!=1
),

 INDIRECT1 AS (
SELECT employee_id
FROM Employees
WHERE manager_id IN (SELECT employee_id FROM DIRECT)
)

SELECT employee_id
FROM Employees
WHERE manager_id IN (SELECT employee_id FROM INDIRECT1)
UNION 
SELECT employee_id
FROM INDIRECT1
UNION 
SELECT employee_id
FROM DIRECT

-- use inner join 
SELECT E1.employee_id
FROM Employees E1
JOIN Employees E2
JOIN Employees E3
ON  E1.manager_id = E2.employee_id 
    AND E2.manager_id = E3.employee_id
    AND E3.manager_id = 1 AND E1.employee_id <> 1