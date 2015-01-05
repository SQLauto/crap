SELECT TOP 10
 tsu.session_id, tsu.request_id, tsu.task_alloc, tsu.task_dealloc,
 erq.command, erq.database_id, DB_NAME(erq.database_id) AS [database_name],
 (SELECT SUBSTRING([text], statement_start_offset/2 + 1,
  (CASE WHEN statement_end_offset = -1
   THEN LEN(CONVERT(nvarchar(max), [text])) * 2
   ELSE statement_end_offset
   END - statement_start_offset) / 2
  )
  FROM sys.dm_exec_sql_text(erq.[sql_handle])) AS query_text,
  qp.query_plan
FROM
 (SELECT session_id, request_id,
  SUM(internal_objects_alloc_page_count + user_objects_alloc_page_count) as task_alloc,
  SUM(internal_objects_dealloc_page_count + user_objects_dealloc_page_count) as task_dealloc
  FROM sys.dm_db_task_space_usage
  GROUP BY session_id, request_id) AS tsu
 INNER JOIN sys.dm_exec_requests AS erq ON tsu.session_id = erq.session_id AND tsu.request_id = erq.request_id
 OUTER APPLY sys.dm_exec_query_plan(erq.[plan_handle]) AS qp
WHERE tsu.session_id > 50 AND database_id >= 5
ORDER BY tsu.task_alloc DESC
GO