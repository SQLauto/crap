SELECT session_id, wait_duration_ms, resource_description, wait_type
FROM sys.dm_os_waiting_tasks
WHERE resource_description like '2:%' AND wait_type LIKE 'PAGE%LATCH%'
ORDER BY wait_duration_ms DESC