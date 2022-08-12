'''
link: https://leetcode.com/problems/the-category-of-each-member-in-the-store/

Table: Members
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| member_id   | int     |
| name        | varchar |
+-------------+---------+
member_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a member.
 

Table: Visits

+-------------+------+
| Column Name | Type |
+-------------+------+
| visit_id    | int  |
| member_id   | int  |
| visit_date  | date |
+-------------+------+
visit_id is the primary key column for this table.
member_id is a foreign key to member_id from the Members table.
Each row of this table contains information about the date of a visit to the store and the member who visited it.
 

Table: Purchases

+----------------+------+
| Column Name    | Type |
+----------------+------+
| visit_id       | int  |
| charged_amount | int  |
+----------------+------+
visit_id is the primary key column for this table.
visit_id is a foreign key to visit_id from the Visits table.
Each row of this table contains information about the amount charged in a visit to the store.
 

A store wants to categorize its members. There are three tiers:

"Diamond": if the conversion rate is greater than or equal to 80.
"Gold": if the conversion rate is greater than or equal to 50 and less than 80.
"Silver": if the conversion rate is less than 50.
"Bronze": if the member never visited the store.
The conversion rate of a member is (100 * total number of purchases for the member) / total number of visits for the member.

Write an SQL query to report the id, the name, and the category of each member.

Return the result table in any order.
'''
-- hint: create a CTE to calculate number of vists and number of purchases, then select from cte with CASE WHEN method
WITH CTE AS (
SELECT V.visit_id
    , V.member_id
    , SUM(1) over (partition by member_id) AS visit_times
    , COUNT(charged_amount) AS purchase
FROM Visits AS V
LEFT JOIN Purchases AS P
ON V.visit_id = P.visit_id
GROUP BY visit_id
)

SELECT M.member_id
    , M.name
    , CASE  
        WHEN 100 * sum(purchase)/visit_times >= 80 THEN "Diamond"
        WHEN 100 * sum(purchase)/visit_times >= 50 AND 100 * sum(purchase)/visit_times < 80 THEN "Gold"
        WHEN 100 * sum(purchase)/visit_times < 50 THEN "Silver"
        WHEN 100 * sum(purchase)/visit_times IS NULL THEN "Bronze" 
      END AS category
FROM  Members M
LEFT JOIN CTE
ON M.member_id = CTE.member_id
GROUP BY M.member_id