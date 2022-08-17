'''
link: https://leetcode.com/problems/calculate-the-influence-of-each-salesperson/

Table: Salesperson
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| salesperson_id | int     |
| name           | varchar |
+----------------+---------+
salesperson_id is the primary key for this table.
Each row in this table shows the ID of a salesperson.
 

Table: Customer

+----------------+------+
| Column Name    | Type |
+----------------+------+
| customer_id    | int  |
| salesperson_id | int  |
+----------------+------+
customer_id is the primary key for this table.
salesperson_id is a foreign key from the Salesperson table.
Each row in this table shows the ID of a customer and the ID of the salesperson. 
 

Table: Sales

+-------------+------+
| Column Name | Type |
+-------------+------+
| sale_id     | int  |
| customer_id | int  |
| price       | int  |
+-------------+------+
sale_id is the primary key for this table.
customer_id is a foreign key from the Customer table.
Each row in this table shows ID of a customer and the price they paid for the sale with sale_id.
 

Write an SQL query to report the sum of prices paid by the customers of each salesperson. If a salesperson does not have any customers, the total value should be 0.

Return the result table in any order.

'''

-- hint: simple left join + group by, with ifnull() method
SELECT s.salesperson_id
     , s.name
     , IFNULL(SUM(price),0) AS total
FROM Salesperson s
LEFT JOIN Customer c
ON c.salesperson_id = s.salesperson_id
LEFT JOIN Sales sa
ON c.customer_id = sa.customer_id
GROUP BY s.salesperson_id