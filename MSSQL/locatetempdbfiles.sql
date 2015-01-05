SELECT name, physical_name AS location
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');