/* Finds duplicates in a table and returns the distinct key column of the duplicate 

OurColumn is where we put our unique column identifier
OurTableName is where we put our table that has duplicates

*/
;WITH DuplicateFinder (OurColumn,DupCounter)
AS
(SELECT OurColumn
,ROW_NUMBER() OVER(PARTITION BY OurColumn ORDER BY OurColumn) AS DupCounter
FROM OurTableName)
SELECT * INTO #investigate FROM DuplicateFinder
WHERE DupCounter > 1

SELECT DISTINCT OurColumn
FROM #investigate

/* Deletes duplicates in a table; this assumes that our table has duplicates across all columns

OurColumn is where we put our unique column identifier
OurTableName is where we put our table that has duplicates

*/
;WITH DuplicateRemover (OurColumn,DupCounter)
AS
(SELECT OurColumn
,ROW_NUMBER() OVER(PARTITION BY OurColumn ORDER BY OurColumn) AS DupCounter
FROM OurTableName)
DELETE FROM DuplicateRemover
WHERE DupCounter > 1

/* EXAMPLE */

-- Creates a temp table 
DECLARE @clean TABLE (
	A INT, 
	B INT, 
	Date DATETIME
)

-- Insert values into the temp table
INSERT INTO @clean VALUES(1,1,getdate())
INSERT INTO @clean VALUES(1,1,DATEADD(DD,-2,getdate()))
INSERT INTO @clean VALUES(1,1,DATEADD(DD,-5,getdate()))
INSERT INTO @clean VALUES(1,2,DATEADD(DD,-10,getdate()))
INSERT INTO @clean VALUES(1,2,DATEADD(DD,-15,getdate()))
INSERT INTO @clean VALUES(3,1,getdate())

-- Shows the full amount of values in the temp table
SELECT *
FROM @clean

-- Deletes the duplicate B's (notice that there were 3 1s and 2 2s in the B column)
;WITH DuplicateRemover (A,B,DupCounter)
AS
(SELECT A
,B
,ROW_NUMBER() OVER(PARTITION BY A,B ORDER BY Date DESC) AS DupCounter
FROM @clean)
DELETE FROM DuplicateRemover
WHERE DupCounter > 1

-- Temp table without the duplicates
SELECT *
FROM @clean
