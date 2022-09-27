'''
link: https://leetcode.com/problems/second-highest-salary/

Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

The query result format is in the following example.
'''

-- Method1: use NOT IN clause to manually filter out the max value 
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary NOT IN
(
    SELECT MAX(salary) 
    FROM Employee
)

-- Method 2: use OFFSET method (better)
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary


-- Method3: cte with limit offset 
-- Q: how to get the right answer when cte returns nothing?
WITH CTE AS (
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1)

SELECT MAX(salary) AS SecondHighestSalary
FROM CTE


-- Method4: use aggregrate function to convert empty answer to null
WITH CTE AS (
SELECT salary
    , RANK() OVER (ORDER BY salary DESC) AS SALARYRANK
FROM Employee)

SELECT MAX(salary) AS SecondHighestSalary
FROM CTE
WHERE SALARYRANK=2

