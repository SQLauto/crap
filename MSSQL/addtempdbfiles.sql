ALTER DATABASE tempdb
ADD FILE (NAME = tempdev2, FILENAME = 'M:\Data\tempdb2.mdf', SIZE = 256);
ALTER DATABASE tempdb
ADD FILE (NAME = tempdev3, FILENAME = 'M:\Data\tempdb3.mdf', SIZE = 256);
ALTER DATABASE tempdb
ADD FILE (NAME = tempdev4, FILENAME = 'M:\Data\tempdb4.mdf', SIZE = 256);
GO