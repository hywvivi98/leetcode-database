'''
link: https://leetcode.com/problems/article-views-ii/
Table: Views

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
 

Write an SQL query to find all the people who viewed more than one article on the same date.

Return the result table sorted by id in ascending order.
'''
-- Method1: aggregrate function + having
SELECT DISTINCT viewer_id AS id
FROM Views
GROUP BY viewer_id,view_date
HAVING COUNT(DISTINCT article_id)>1

-- Method2: self-join based on multiple filtering conditions
SELECT DISTINCT v1.viewer_id AS id
FROM views v1
JOIN views v2
ON v1.viewer_id = v2.viewer_id
AND v1.view_date = v2.view_date
AND v1.article_id != v2.article_id
ORDER BY id