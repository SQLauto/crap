ALTER DATABASE tempdb
ADD FILE (NAME = tempdev2, FILENAME = 'D:\tempdb\tempdb2.mdf', SIZE = 256);
ALTER DATABASE tempdb
ADD FILE (NAME = tempdev3, FILENAME = 'D:\tempdb\tempdb3.mdf', SIZE = 256);
ALTER DATABASE tempdb
ADD FILE (NAME = tempdev4, FILENAME = 'D:\tempdb\tempdb4.mdf', SIZE = 256);
GO