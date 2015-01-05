/* 

Working with Object IDs in stored procedures

*/

CREATE PROCEDURE tsp_show
AS
BEGIN
-- We can check if a table exists, and remove it if it does
IF OBJECT_ID('tempdb..#ztmp') IS NOT NULL DROP TABLE #ztmp

-- Create an experiment table
CREATE TABLE #ztmp (
	Name VARCHAR(50)
)

-- Insert experimental values
INSERT INTO #ztmp VALUES ('This is a real table')

-- Find the Object ID of a table
SELECT 'The OBJECT ID of the table is: ' + CAST(OBJECT_ID('tempdb..#ztmp') AS VARCHAR(10)) AS "Object ID"

END