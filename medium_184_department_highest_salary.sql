'''
link: https://leetcode.com/problems/department-highest-salary/

Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key column for this table.
departmentId is a foreign key of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of a department and its name.
 

Write an SQL query to find employees who have the highest salary in each of the departments.
'''
WITH CTE AS (
SELECT D.name AS Department
    , E.name AS Employee
    , E.salary AS Salary
    , DENSE_RANK() OVER (PARTITION BY D.name ORDER BY E.salary DESC ) AS denseRank

FROM Employee E
JOIN Department D
ON E.departmentId = D.ID
    )

SELECT Department
    , Employee
    , Salary
FROM CTE
WHERE denseRank = 1


