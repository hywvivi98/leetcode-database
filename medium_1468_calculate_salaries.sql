'''
link: https://leetcode.com/problems/calculate-salaries/

Table Salaries:
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| company_id    | int     |
| employee_id   | int     |
| employee_name | varchar |
| salary        | int     |
+---------------+---------+
(company_id, employee_id) is the primary key for this table.
This table contains the company id, the id, the name, and the salary for an employee.
 

Write an SQL query to find the salaries of the employees after applying taxes. Round the salary to the nearest integer.

The tax rate is calculated for each company based on the following criteria:

0% If the max salary of any employee in the company is less than $1000.
24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
49% If the max salary of any employee in the company is greater than $10000.
Return the result table in any order.
'''

-- hint: create cte to indicate salary deduction percentage, 
-- then join with original table to calculate aftre-tax salaries
WITH CTE AS (
SELECT company_id
    , CASE WHEN MAX(salary) < 1000 THEN 1
           WHEN MAX(salary) >= 1000 AND MAX(salary) <= 10000 THEN 0.76 
           WHEN MAX(salary) > 10000 THEN 0.51 END AS salary_deduction
FROM Salaries
GROUP BY company_id
)

SELECT S.company_id
    , employee_id
    , employee_name
    , ROUND(S.salary * salary_deduction,0) AS salary
FROM Salaries S
JOIN CTE
ON S.company_id = CTE.company_id