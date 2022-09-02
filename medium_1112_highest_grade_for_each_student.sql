'''
link: https://leetcode.com/problems/highest-grade-for-each-student/
able: Enrollments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key of this table.
 

Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.

Return the result table ordered by student_id in ascending order.
'''
-- Method1: CTE + row_number/rank/dense_rank() window function
WITH CTE AS (
SELECT student_id
    , course_id
    , grade
    , ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY grade DESC, course_id) RANKNUM
FROM Enrollments)

SELECT DISTINCT student_id
    , course_id
    , grade
FROM CTE
WHERE RANKNUM=1

-- Method2: min(), max() + IN()
SELECT DISTINCT student_id
    , MIN(course_id) AS course_id
    , grade 
FROM Enrollments
WHERE (student_id,grade) IN 
                        (SELECT DISTINCT student_id
                            , max(grade) 
                         FROM Enrollments 
                         GROUP BY student_id)
GROUP BY student_id 
ORDER BY student_id
