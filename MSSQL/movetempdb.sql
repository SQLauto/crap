USE master;
GO
ALTER DATABASE tempdb
MODIFY FILE
(NAME = tempdev, FILENAME = 'D:\tempdb\Tempdb.mdf');
GO
ALTER DATABASE tempdb
MODIFY FILE
(NAME = templog, FILENAME = 'D:\tempdb\Tempdb.ldf');
GO