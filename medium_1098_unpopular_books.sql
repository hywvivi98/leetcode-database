'''
link:https://leetcode.com/problems/unpopular-books/
Table: Books

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| book_id        | int     |
| name           | varchar |
| available_from | date    |
+----------------+---------+
book_id is the primary key of this table.
 

Table: Orders

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| order_id       | int     |
| book_id        | int     |
| quantity       | int     |
| dispatch_date  | date    |
+----------------+---------+
order_id is the primary key of this table.
book_id is a foreign key to the Books table.
 

Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23.

Return the result table in any order.
'''
-- an edge case when we must use NOT IN ()
WITH CTE AS (
SELECT book_id
    , dispatch_date
    , SUM(quantity) AS TOTAL
FROM Orders
WHERE TIMESTAMPDIFF(YEAR, dispatch_date,"2019-06-23") = 0
GROUP BY book_id
HAVING TOTAL >=10
)

SELECT Books.book_id
    , Books.name
FROM Books
WHERE available_from < "2019-05-23"
AND Books.book_id NOT IN (SELECT book_id FROM CTE)
-- some books available_from early than '2019-05-23', but no sales during '2018-06-23' and '2019-06-23', 
-- so the Group BY cannot reflect those book with no sales, 
-- however, they are book that have less than 10 copies sold. 
-- So, we have to use NOT IN (those books sold more than 10 copies), instead of IN (those books sold less than 10 copies (0 copy books not included))


-- Method2: left join and group by
SELECT b.book_id
    , b.name
FROM 
-- Filter first and join later will perform better if the data set is huge is required run in distributed environment
(SELECT * FROM books WHERE available_from <= "2019-05-23") b 
LEFT JOIN (SELECT * FROM orders WHERE dispatch_date >= "2018-06-23") o
ON b.book_id=o.book_id 
GROUP BY  b.book_id,b.name
HAVING SUM(o.quantity) IS NULL OR SUM(quantity)<10