/* 

Find the column names, data types and character lengths only change two values in steps

*/

-- STEP ONE: Change Database Name
USE OurDatabaseName
GO

DECLARE @info TABLE (
	[Column Name] VARCHAR(250),
	[Data Type] VARCHAR(50),
	[Character Length] VARCHAR(50)
)

INSERT INTO @info
SELECT COLUMN_NAME
, DATA_TYPE
, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
-- STEP TWO: Change Table Name
WHERE TABLE_NAME = 'OurTableName'

UPDATE @info
SET [Character Length] = 'N/A  ' + [Data Type]
WHERE [Character Length] IS NULL

SELECT *
FROM @info