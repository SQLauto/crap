-- GH test
--  Replace

CREATE TABLE DatabaseGrowthMonitoring(
	DatabaseID SMALLINT,
	FileType TINYINT,
	SizeInMB DECIMAL(18,2),
	[Date] DATE DEFAULT GETDATE()
)

CREATE TABLE DatabaseGrowthPercent(
	DatabaseID SMALLINT,
	[Date] DATE,
	PercentGrowth DECIMAL(18,2)
)

CREATE PROCEDURE stp_DailyDatabaseSize
AS
BEGIN


INSERT INTO DatabaseGrowthMonitoring (DatabaseID,FileType,SizeInMB)
SELECT database_id
	, type
	, (Size*8)/1024 SizeInMB
FROM sys.master_files
WHERE DB_NAME(database_id) NOT IN ('master','tempdb','model','msdb')
	AND GETDATE() NOT IN (SELECT [Date] FROM DatabaseGrowthMonitoring)


END

CREATE PROCEDURE stp_MonitorGrowth
AS
BEGIN


INSERT INTO DatabaseGrowthPercent
SELECT d1.DatabaseID
	, d1.Date
	, (((d1.SizeInMB-d2.SizeInMB)/(d2.SizeInMB))*100) AS "Growth"
FROM DatabaseGrowthMonitoring d1
	INNER JOIN DatabaseGrowthMonitoring d2 ON d1.DatabaseID = d2.DatabaseID 
		AND d1.FileType = d2.FileType 
		AND d2.Date = DATEADD(DD,-1,d1.Date)
WHERE d1.Date NOT IN (SELECT [Date] FROM DatabaseGrowthPercent)


END
