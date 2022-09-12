'''
link: https://leetcode.com/problems/movie-rating/
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key for this table.
 

Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key for this table.
This table contains the rating of a movie by a user in their review.
created_at is the users review date. 
 

Write an SQL query to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
The query result format is in the following example.
'''
-- UNION ALL
WITH CTE1 AS (
SELECT U.name AS results
FROM MovieRating M
JOIN Users U 
ON M.user_id = U.user_id
GROUP BY M.user_id
ORDER BY COUNT(M.user_id) DESC,name
LIMIT 1
    ),


CTE2 AS (
SELECT MO.title AS results
FROM MovieRating M
JOIN Movies MO 
ON M.movie_id = MO.movie_id
WHERE YEAR(created_at) = 2020 AND MONTH(created_at) = 2
GROUP BY M.movie_id
ORDER BY AVG(M.rating) DESC, title
LIMIT 1)

SELECT results
FROM CTE1
UNION ALL
SELECT results
FROM CTE2

