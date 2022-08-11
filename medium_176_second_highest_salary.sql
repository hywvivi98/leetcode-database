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

'''
Q: how to get the right answer when cte returns nothing?
with cte as (
select distinct salary from Employee
order by salary desc
limit 1 offset 1
)
select salary SecondHighestSalary from cte 
'''

