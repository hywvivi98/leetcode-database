'''
link: https://leetcode.com/problems/department-top-three-salaries/

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
 

A company s executives are interested in seeing who earns the most money in each of the company s departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write an SQL query to find the employees who are high earners in each of the departments.

Return the result table in any order.

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
WHERE denseRank <= 3