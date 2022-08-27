'''
link:https://leetcode.com/problems/get-highest-answer-rate-question/
Table: SurveyLog

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| action      | ENUM |
| question_id | int  |
| answer_id   | int  |
| q_num       | int  |
| timestamp   | int  |
+-------------+------+
There is no primary key for this table. It may contain duplicates.
action is an ENUM of the type: "show", "answer", or "skip".
Each row of this table indicates the user with ID = id has taken an action with the question question_id at time timestamp.
If the action taken by the user is "answer", answer_id will contain the id of that answer, otherwise, it will be null.
q_num is the numeral order of the question in the current session.
 

The answer rate for a question is the number of times a user answered the question by the number of times a user showed the question.

Write an SQL query to report the question that has the highest answer rate. If multiple questions have the same maximum answer rate, report the question with the smallest question_id.
'''
-- use aggregrate function to calculate nominator and denominator, order by percentage
WITH CTE AS (
SELECT id
    , question_id
    , SUM(CASE WHEN action = "answer" THEN 1 ELSE 0 END) AS sum_action
    , SUM(CASE WHEN action = "show" THEN 1 ELSE 0 END) AS sum_show
FROM SurveyLog
GROUP BY question_id
)

SELECT question_id AS survey_log
FROM CTE
ORDER BY sum_action/sum_show DESC, question_id
LIMIT 1