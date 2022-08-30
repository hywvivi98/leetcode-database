'''
link:https://leetcode.com/problems/evaluate-boolean-expression/
Table Variables:

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| name          | varchar |
| value         | int     |
+---------------+---------+
name is the primary key for this table.
This table contains the stored variables and their values.
 

Table Expressions:

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| left_operand  | varchar |
| operator      | enum    |
| right_operand | varchar |
+---------------+---------+
(left_operand, operator, right_operand) is the primary key for this table.
This table contains a boolean expression that should be evaluated.
operator is an enum that takes one of the values ('<', '>', '=')
The values of left_operand and right_operand are guaranteed to be in the Variables table.
 

Write an SQL query to evaluate the boolean expressions in Expressions table.

Return the result table in any order.

'''
-- hint: use IF() to return results based on different cases
--  differentiate boolean True/False vs. string "true"/"false" 
-- mixed use of case when and if
SELECT left_operand
    , operator
    , right_operand
    # , V1.value
    # , V2.value
    , CASE WHEN operator = ">" THEN IF (V1.value > V2.value, "true", "false")
            WHEN operator = "<" THEN IF (V1.value < V2.value, "true", "false")
            WHEN operator = "=" THEN IF (V1.value = V2.value, "true", "false") 
    END AS value
# CASE WHEN left_operand = "x" THEN V.x ELSE V.y
FROM Expressions
LEFT JOIN Variables V1
ON Expressions.left_operand = V1.name
LEFT JOIN Variables V2
ON Expressions.right_operand = V2.name