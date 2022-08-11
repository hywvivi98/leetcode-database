'''
link: https://leetcode.com/problems/arrange-table-by-gender/

Table: Genders
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| gender      | varchar |
+-------------+---------+
user_id is the primary key for this table.
gender is ENUM of type 'female', 'male', or 'other'.
Each row in this table contains the ID of a user and their gender.
The table has an equal number of 'female', 'male', and 'other'.
Write an SQL query to rearrange the Genders table such that the rows alternate between 'female', 'other', and 'male' in order. The table should be rearranged such that the IDs of each gender are sorted in ascending order.

Return the result table in the mentioned order.

The query result format is shown in the following example.
'''
-- hint: window function with rank over different categories 
WITH CTE AS(
SELECT user_id
    , gender
    , RANK() OVER (PARTITION BY gender ORDER BY user_id) AS GENDER_ORDER
FROM Genders
)

SELECT user_id
    , gender
FROM CTE
ORDER BY GENDER_ORDER,gender