-- Replace

/* SET Database Name */
USE OurDatabaseName
GO

/* Two Columns */

DECLARE @Results TABLE (
	RTable VARCHAR(100),
	RColumn VARCHAR(100)
)

DECLARE @column1 AS VARCHAR(50)
DECLARE @column2 AS VARCHAR(50)
/* ONLY MAKE CHANGES HERE: */
SET @column1 = 'Our Column Name'
SET @column2 = 'Our Column Name'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", ISC.COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column1 +'%'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column2 +'%'

SELECT DISTINCT RTable, COUNT(RColumn) AS "Having 2 Columns"
FROM @results
GROUP BY RTable
HAVING COUNT(RColumn) > 1


/* Three Columns */

USE OurDatabaseName
GO

DECLARE @Results TABLE (
	RTable VARCHAR(100),
	RColumn VARCHAR(100)
)

DECLARE @column1 AS VARCHAR(50)
DECLARE @column2 AS VARCHAR(50)
DECLARE @column3 AS VARCHAR(50)
/* ONLY MAKE CHANGES HERE: */
SET @column1 = 'Our Column Name'
SET @column2 = 'Our Column Name'
SET @column3 = 'Our Column Name'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", ISC.COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column1 +'%'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column2 +'%'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column3 +'%'

SELECT DISTINCT RTable, COUNT(RColumn) AS "Having 3 Columns"
FROM @results
GROUP BY RTable
HAVING COUNT(RColumn) > 2


/* Four Columns */

USE OurDatabaseName
GO

DECLARE @Results TABLE (
	RTable VARCHAR(100),
	RColumn VARCHAR(100)
)

DECLARE @column1 AS VARCHAR(50)
DECLARE @column2 AS VARCHAR(50)
DECLARE @column3 AS VARCHAR(50)
DECLARE @column4 AS VARCHAR(50)
/* ONLY MAKE CHANGES HERE: */
SET @column1 = 'Our Column Name'
SET @column2 = 'Our Column Name'
SET @column3 = 'Our Column Name'
SET @column4 = 'Our Column Name'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", ISC.COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column1 +'%'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column2 +'%'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column3 +'%'

INSERT INTO @Results
SELECT ISC.TABLE_NAME AS "Table", COLUMN_NAME AS "Full Column Name"
FROM information_schema.COLUMNS ISC
WHERE ISC.column_name LIKE '%' + @column4 +'%'

SELECT DISTINCT RTable, COUNT(RColumn) AS "Having 4 Columns"
FROM @results
GROUP BY RTable
HAVING COUNT(RColumn) > 3
