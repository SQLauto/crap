Create procedure FileLocations
AS
SELECT db_name(database_id) as DatabaseName,name,type_desc,physical_name
FROM sys.master_files
GO