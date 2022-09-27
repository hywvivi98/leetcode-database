'''
link: https://leetcode.com/problems/nth-highest-salary/

Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.
'''
-- hint: declare and set variable within SQL
-- helpful resource: https://towardsdatascience.com/declaring-variables-within-sql-fe6a479a7f9c
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M = N-1;
  RETURN (
      # Write your MySQL query statement below.

      SELECT IFNULL(
          (SELECT distinct salary from Employee
           order by Salary desc
           limit M,1)
          --  equivalent to LIMIT [offset,] row_count;
      ,NULL) AS getNthHighestSalary
  );
END

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      WITH CTE AS (
SELECT salary
    , DENSE_RANK() OVER (ORDER BY salary DESC) AS SALARYRANK
FROM Employee)

SELECT MAX(salary) AS getNthHighestSalary
FROM CTE
WHERE SALARYRANK=N
      
  );
END