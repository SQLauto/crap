Create procedure ExpensiveQueries
AS
DECLARE @MinExecutions int;
SET @MinExecutions = 5
 SELECT A.total_worker_time AS TotalWorkerTime
	  ,A.total_logical_reads + A.total_logical_writes AS TotalLogicalIO
      ,A.execution_count As ExeCnt
      ,A.last_execution_time AS LastUsage
      ,A.total_worker_time / A.execution_count as AvgCPUTimeMiS
      ,(A.total_logical_reads + A.total_logical_writes) / A.execution_count 
       AS AvgLogicalIO
      ,DB.name AS DatabaseName
      ,SUBSTRING(B.text
                ,1 + A.statement_start_offset / 2
                ,(CASE WHEN A.statement_end_offset = -1 
                       THEN LEN(convert(nvarchar(max), B.text)) * 2 
                       ELSE A.statement_end_offset END 
                 - A.statement_start_offset) / 2
                ) AS SqlStatement
        ,C.[query_plan] AS [QueryPlan]
FROM sys.dm_exec_query_stats AS A
     CROSS APPLY sys.dm_exec_sql_text(A.sql_handle) AS B
     CROSS APPLY sys.dm_exec_query_plan(A.plan_handle) AS C
     LEFT JOIN sys.databases AS DB
         ON B.dbid = DB.database_id     
WHERE  A.last_execution_time > DATEDIFF(MONTH, -1, GETDATE())
ORDER BY AvgLogicalIo DESC
        ,AvgCPUTimeMiS DESC
GO