/* 

Non Parameter DMV/DMFs of SQL Server

*/

SELECT *
FROM sys.dm_exec_connections
-- Shows detailed information about the server's connections, such as Session ID, Connect Time, etc.

SELECT *
FROM sys.dm_exec_sessions
-- Shows login details about active users as well as the amount of the server is processing (total)

SELECT *
FROM sys.dm_exec_requests
-- Provides information about each server request

SELECT *
FROM sys.dm_exec_cached_plans
-- Provides each query plan cached by the server to reduce execution time

SELECT *
FROM sys.dm_exec_query_stats
-- Provides statistics about cached query plans, such as reads, writes, etc

SELECT *
FROM sys.dm_db_index_usage_stats
-- Returns index related information including when it happened

SELECT *
FROM sys.dm_os_performance_counters
-- Provides performance counters

SELECT *
FROM sys.dm_os_schedulers
-- Helpful for reviewing schedulers

SELECT *
FROM sys.dm_os_nodes
-- Gives information about nodes, imitating hardware process locality

SELECT *
FROM sys.dm_os_waiting_tasks
-- Provides information about tasks waiting

SELECT *
FROM sys.dm_os_wait_stats
-- Good for assessing performance issues with the server