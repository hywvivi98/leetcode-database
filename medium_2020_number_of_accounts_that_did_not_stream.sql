'''
link:https://leetcode.com/problems/number-of-accounts-that-did-not-stream/
Table: Subscriptions

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| start_date  | date |
| end_date    | date |
+-------------+------+
account_id is the primary key column for this table.
Each row of this table indicates the start and end dates of an accounts subscription.
Note that always start_date < end_date.
 

Table: Streams

+-------------+------+
| Column Name | Type |
+-------------+------+
| session_id  | int  |
| account_id  | int  |
| stream_date | date |
+-------------+------+
session_id is the primary key column for this table.
account_id is a foreign key from the Subscriptions table.
Each row of this table contains information about the account and the date associated with a stream session.
 

Write an SQL query to report the number of accounts that bought a subscription in 2021 but did not have any stream session.
'''
-- notes: count() method will always ignore null values
SELECT COUNT(*) AS accounts_count
FROM Subscriptions S
JOIN Streams T
ON S.account_id = T.account_id
WHERE YEAR(end_date)=2021 
    AND stream_date < end_date
    # AND stream_date >start_date
    AND YEAR(stream_date) = 2020