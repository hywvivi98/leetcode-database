'''
link: https://leetcode.com/problems/rearrange-products-table/
able: Products

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| store1      | int     |
| store2      | int     |
| store3      | int     |
+-------------+---------+
product_id is the primary key for this table.
Each row in this table indicates the products price in 3 different stores: store1, store2, and store3.
If the product is not available in a store, the price will be null in that stores column.
 

Write an SQL query to rearrange the Products table so that each row has (product_id, store, price). If a product is not available in a store, do not include a row with that product_id and store combination in the result table.

Return the result table in any order.
'''
-- Method1: use union all 
WITH CTE AS (
SELECT product_id
    , "store1" AS store
    , store1 AS price
FROM Products
UNION ALL 
SELECT product_id
    , "store2" AS store
    , store2 AS price
FROM Products
UNION ALL 
SELECT product_id
    , "store3" AS store
    , store3 AS price
FROM Products)


SELECT product_id
    , store
    , price
FROM CTE 
WHERE price IS NOT NULL


-- uppivot-> not available in Mysql
'''
-- link: https://docs.snowflake.com/en/sql-reference/constructs/unpivot.html#syntax
SELECT ...
FROM ...
   UNPIVOT ( <value_column>
             FOR <name_column> IN ( <column_list> ) )

[ ... ]
'''
SELECT product_id,store,price
FROM Products
UNPIVOT
(
	price
	FOR store in (store1,store2,store3)
) AS T