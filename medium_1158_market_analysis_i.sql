'''
link:https://leetcode.com/problems/market-analysis-i/
Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |
+----------------+---------+
user_id is the primary key of this table.
This table has the info of the users of an online shopping website where users can sell and buy items.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the primary key of this table.
item_id is a foreign key to the Items table.
buyer_id and seller_id are foreign keys to the Users table.
Table: Items

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| item_id       | int     |
| item_brand    | varchar |
+---------------+---------+
item_id is the primary key of this table.
 

Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.

Return the result table in any order.

'''
-- be careful about order join order (think about what values do we want to keep)
SELECT user_id AS buyer_id
    , join_date
    -- don't use COUNT(*) in general, think about the specific items need to count
    , COUNT(buyer_id) AS orders_in_2019
FROM Users U
LEFT JOIN Orders O
ON O.buyer_id = U.user_id
-- YEAR() function!!
AND YEAR(order_date) = 2019
GROUP BY user_id
