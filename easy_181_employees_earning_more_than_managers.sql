'''
link: https://leetcode.com/problems/employees-earning-more-than-their-managers/

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

Write an SQL query to find the employees who earn more than their managers.

Return the result table in any order.

The query result format is in the following example.
'''
-- inner join with the same table, filter with joining key
SELECT
     a.NAME AS Employee
FROM Employee AS a INNER JOIN Employee AS b
     ON a.ManagerId = b.Id
     AND a.salary > b.salary