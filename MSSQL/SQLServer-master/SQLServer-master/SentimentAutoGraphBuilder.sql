-- Format of the main sentiment table
CREATE TABLE [Sentiment](
	[Date] [date] NULL,
	[Positive] [decimal](5, 2) NULL,
	[Negative] [decimal](5, 2) NULL
)
/*

This main sentiment table allows for easy data entry:
1.  Enter the date
2.  Enter the positive data
3.  Enter the negative data

*/

-- Report table
DECLARE @SentimentReport TABLE (
	January DECIMAL(5,2),
	February DECIMAL(5,2),
	March DECIMAL(5,2),
	April DECIMAL(5,2),
	May DECIMAL(5,2),
	June DECIMAL(5,2),
	July DECIMAL(5,2),
	August DECIMAL(5,2),
	September DECIMAL(5,2),
	October DECIMAL(5,2),
	November DECIMAL(5,2),
	December DECIMAL(5,2)
)

-- Stage, clean and organization table
DECLARE @sentiment TABLE (
	StDate VARCHAR(10),
	Positive DECIMAL(5,2),
	Negative DECIMAL(5,2)
)

-- Enter data into stage table month-by-month; only replace OurTableName
INSERT INTO @sentiment
SELECT 'January', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-01-01' AND '2013-01-31'

INSERT INTO @sentiment
SELECT 'February', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-02-01' AND '2013-02-28'

INSERT INTO @sentiment
SELECT 'March', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-03-01' AND '2013-03-31'

INSERT INTO @sentiment
SELECT 'April', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-04-01' AND '2013-04-30'

INSERT INTO @sentiment
SELECT 'May', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-05-01' AND '2013-05-31'

INSERT INTO @sentiment
SELECT 'June', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-06-01' AND '2013-06-30'

INSERT INTO @sentiment
SELECT 'July', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-07-01' AND '2013-07-31'

INSERT INTO @sentiment
SELECT 'August', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-08-01' AND '2013-08-31'

INSERT INTO @sentiment
SELECT 'September', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-09-01' AND '2013-09-30'

INSERT INTO @sentiment
SELECT 'October', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-10-01' AND '2013-10-31'

INSERT INTO @sentiment
SELECT 'November', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-11-01' AND '2013-11-30'

INSERT INTO @sentiment
SELECT 'December', AVG(Positive), AVG(Negative)
FROM OurTableName
WHERE Date BETWEEN '2013-12-01' AND '2013-12-31'

-- Insert the pivoted positive and negative data
INSERT INTO @SentimentReport
SELECT January,February,March,April,May,June,July,August,September,October,November,December
FROM (SELECT StDate, [Positive] FROM @sentiment) AS SourceTable
PIVOT(
AVG(Positive) FOR StDate IN (January,February,March,April,May,June,July,August,September,October,November,December)
) AS PivotTable;

INSERT INTO @SentimentReport
SELECT January,February,March,April,May,June,July,August,September,October,November,December
FROM (SELECT StDate, [Negative] FROM @sentiment) AS SourceTable
PIVOT(
AVG(Negative) FOR StDate IN (January,February,March,April,May,June,July,August,September,October,November,December)
) AS PivotTable;

-- View final table
SELECT *
FROM @SentimentReport