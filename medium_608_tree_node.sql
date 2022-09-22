'''
link: https://leetcode.com/problems/tree-node/
Table: Tree

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| p_id        | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the id of a node and the id of its parent node in a tree.
The given structure is always a valid tree.
 

Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.

Return the result table ordered by id in ascending order.
'''
-- Method1: LEFT JOIN 
SELECT DISTINCT A.id
    , CASE WHEN B.id IS NULL and A.p_id IS NOT NULL THEN "Leaf"
            WHEN B.id IS NOT NULL AND A.p_id IS NOT NULL THEN "Inner"
            WHEN A.p_id IS NULL THEN "Root" END AS type
FROM Tree A
LEFT JOIN Tree B
ON A.id = B.p_id
ORDER BY A.id

-- Method2: use subquery but works worse than LEFT JOIN
SELECT id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM Tree)THEN 'Inner'
        ELSE 'Leaf'
        END AS type
 FROM Tree