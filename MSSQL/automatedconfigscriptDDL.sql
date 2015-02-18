SET NOCOUNT ON
GO

 

IF EXISTS ( SELECT  name
            FROM    tempdb..sysobjects
            Where   name like '>')
DROP TABLE #SerProp
create table #SerProp
    (
      ID int,
      Name sysname,
      Internal_Value int,
      Value nvarchar(512)
    )
GO

sp_configure 'Show Advanced Options', 1
Reconfigure
GO

DECLARE @PhysMem int
DECLARE @ProcType int
DECLARE @MaxMem int

INSERT  INTO #SerProp
        Exec xp_msver
Select  @PhysMem = Internal_Value
from    #SerProp
where   Name = 'PhysicalMemory'

Select  @ProcType = Internal_Value
from    #SerProp
where   Name = 'ProcessorType'

--Set Memory Configuration from server properties
--(memory level and processortype)

If @PhysMem > 4096 AND @ProcType = 8664
BEGIN
   SET @MaxMem = @PhysMem - 3072
   EXEC sp_configure 'max server memory', @MaxMem
   Reconfigure
END  

ELSE
IF @PhysMem > 4096 AND @ProcType <> 8664
BEGIN
   SET @MaxMem = @PhysMem - 3072
   EXEC sp_configure 'awe enabled', 1
   Reconfigure
   EXEC sp_configure 'max server memory', @MaxMem
   Reconfigure
END  

--Setup Security Logging
--Enable Successful and Unsuccessful Login Attempts
--SQL Server Services must be restarted to take affect
exec master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer',
N'AuditLevel', REG_DWORD,3
--Create Maintenance Database "_DBAMain"
USE [master]
GO
/****** Object:  Database [_DBAMain]   
                  Script Date: 02/05/2009 20:41:24 ******/
IF  EXISTS (SELECT name FROM sys.databases
              WHERE name = N'_DBAMain')
DROP DATABASE [_DBAMain]
GO
/****** Object:  Database [_DBAMain]
                  Script Date: 02/05/2009 20:41:24 ******/

CREATE DATABASE [_DBAMain] ON  PRIMARY
( NAME = N'_DBAMain_Data',
   FILENAME = N'M:\Data\_DBAMain_Data.MDF',
   SIZE = 5120KB,
   MAXSIZE = UNLIMITED,
   FILEGROWTH = 10%)
 LOG ON
( NAME = N'_DBAMain_Log',
   FILENAME = N'L:\DATA\_DBAMain_Log.LDF' ,
   SIZE = 3072KB ,
   MAXSIZE = 2048GB ,
   FILEGROWTH = 10%)
GO
/*   
   Run Script To Create Stored Procedures
   In _DBAMain
*/
sp_configure 'xp_cmdshell', 1

--Setup DDL Triggers

--Setup Create Database or Drop Database DDL Trigger

/****** Object:  DdlTrigger [AuditDatabaseDDL]
                  Script Date: 02/05/2009 19:56:33 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [AuditDatabaseDDL]
ON ALL SERVER
FOR CREATE_DATABASE, DROP_DATABASE
AS

DECLARE @data XML,
      @tsqlCommand NVARCHAR(MAX),
      @eventType NVARCHAR(100),
      @serverName NVARCHAR(100),
      @loginName NVARCHAR(100),
      @username NVARCHAR(100),
      @databaseName NVARCHAR(100),
      @objectName NVARCHAR(100),
      @objectType NVARCHAR(100),
      @emailBody NVARCHAR(MAX)
SET @data = EVENTDATA()
SET @tsqlCommand = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
SET @eventType = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(max)')
SET @serverName = EVENTDATA().value('(/EVENT_INSTANCE/ServerName)[1]','nvarchar(max)')
SET @loginName = EVENTDATA().value('(/EVENT_INSTANCE/LoginName)[1]','nvarchar(max)')
SET @userName = EVENTDATA().value('(/EVENT_INSTANCE/UserName)[1]','nvarchar(max)')
SET @databaseName = EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]','nvarchar(max)')
SET @objectName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)')
SET @objectType = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]','nvarchar(max)')
SET @emailBody = + '--------------------------------' + CHAR(13)
             + '- DDL Trigger Activation Report      -' + CHAR(13)
             + '--------------------------------------' + CHAR(13)
             + 'Sql Command: '
                 + ISNULL(@tsqlCommand, 'No Command Given') + CHAR(13)

             + 'Event Type: '
                 + ISNULL(@eventType, 'No Event Type Given') + CHAR(13)
             + 'Server Name:
               ' + ISNULL(@serverName, 'No Server Given') + CHAR(13)
             + 'Login Name: '
                 + ISNULL(@loginName, 'No LOGIN Given') + CHAR(13)
             + 'User Name: '
                 + ISNULL(@username, 'No User Name Given') + CHAR(13)
             + 'DB Name: '
                 + ISNULL(@databaseName, 'No Database Given') + CHAR(13)
             + 'Object Name: '
                 + ISNULL(@objectName, 'No Object Given') + CHAR(13)
             + 'Object Type: '
                 + ISNULL(@objectType, 'No Type Given') + CHAR(13)
             + '-------------------------------------------';
EXEC msdb..sp_send_dbmail @profile_name='Default', @recipients='Jason.Mallory@iridium.com', @subject='DDL Alteration Trigger', @body=@emailBody
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ENABLE TRIGGER [AuditDatabaseDDL] ON ALL SERVER
GO

-- Change Model Database Recovery Option from Full to Simple
-- This will prevent unmitigated log file growth.

ALTER Database Model
SET RECOVERY SIMPLE

-- Run the following:

--sp_configure 'xp_cmdshell', 0
--reconfigure

--sp_configure 'Show Advanced Options', 1
--Reconfigure


-- End Script

PRINT 'All Done...Add Server to DBA Repository for further documentation'