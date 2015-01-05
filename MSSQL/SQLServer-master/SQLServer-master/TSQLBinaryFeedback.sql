/* 

Back end design example for binary feedback, which allows tracking of feedback over time

*/
-- Time tracking method: build the experiment table
DECLARE @meas TABLE(
	Positive INT,
	Negative INT,
	Date DATETIME
)
-- Insert test values into the experiment table
INSERT INTO @meas (Positive,Date) VALUES (1,GETDATE())
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-1,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-2,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-7,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-13,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-27,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-35,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-41,GETDATE()))
INSERT INTO @meas (Positive,Date) VALUES (1,DATEADD(DD,-72,GETDATE()))
INSERT INTO @meas (Negative,Date) VALUES (1,DATEADD(DD,-2,GETDATE()))
INSERT INTO @meas (Negative,Date) VALUES (1,DATEADD(DD,-12,GETDATE()))
INSERT INTO @meas (Negative,Date) VALUES (1,DATEADD(DD,-36,GETDATE()))
-- Shows us our total positive and negative scores
SELECT SUM(Positive) AS Positive, SUM(Negative) AS Negative
FROM @meas
-- Shows us our positive and negative scores for the last month
SELECT SUM(Positive) AS Positive, SUM(Negative) AS Negative
FROM @meas
WHERE Date > DATEADD(DD,-31,GETDATE())
-- Using increment decrement
DECLARE @measplus TABLE(
	Positive INT
)
INSERT INTO @measplus VALUES (0)
-- Positive feedback
UPDATE @measplus
SET Positive = Positive + 1
SELECT * FROM @measplus
-- Negative feedback
UPDATE @measplus
SET Positive = Positive - 1
SELECT * FROM @measplus