'''
link: https://leetcode.com/problems/patients-with-a-condition/
Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key for this table.
conditions contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write an SQL query to report the patient_id, patient_name all conditions of patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix

Return the result table in any order.
'''
-- Method1: use LIKE
SELECT patient_id
    , patient_name
    , conditions
FROM Patients
WHERE conditions LIKE "% DIAB1%" 
-- when there are multiple condition, need to type the whole clause
    OR conditions LIKE "DIAB1%"



-- Method2: use REGEXP
SELECT * FROM patients WHERE conditions REGEXP '\\bDIAB1'