/* SQL Server Automated Configuration Script
   2014 - Jason Mallory
*/
--Create Temp table #SerProp. This table will be used
--to hold the output of xp_msver to control server property
configurations
SET NOCOUNT ON
GO
IF EXISTS ( SELECT  name
            FROM    tempdb..sysobjects
            Where   name like '#SerProp%' )
--If So Drop it
    DROP TABLE #SerProp
create table #SerProp
(
ID int,
      Name sysname,
      Internal_Value int,
      Value nvarchar(512)
)
GO
--Set Show Advanced Option
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
--Setup Database Mail (SQL Server > 2005 )
--Turn on Mail XPs via sp_configure
--sp_configure (To turn on Mail XPs)
-- Add Profile
If @@microsoftversion / power(2, 24) > 8
BEGIN
EXECUTE msdb.dbo.sysmail_add_profile_sp
       @profile_name = 'Admin Profile',
       @description = 'Mail Profile For Alerts' ;
--Add Mail Account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'Admin Account',
    @description = 'General SQL Admin Account for DBA Notification',
    @email_address = '<Your DBA e-mail account>,
    @display_name = 'SQL Admin Account',
    @mailserver_name = '<Yourmailservername>;
--Add Mail Account to Profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Admin Profile',
    @account_name = 'Admin Account',
    @sequence_number = 1 ;
--Send Test Mail
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Admin Profile',
    @recipients = '<Your DBA e-mail Account>,
    @body = 'Sever Mail Configuration Completed,
    @subject = 'Successful Mail Test;
END ELSE
--Setup Security Logging
--Enable Successful and Unsuccessful Login Attempts
--SQL Server Services must be restarted to take affect
exec master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE',
N'Software\Microsoft\MSSQLServer\MSSQLServer',
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
   FILENAME = N'C:\Data\_DBAMain_Data.MDF',
   SIZE = 5120KB,
   MAXSIZE = UNLIMITED,
   FILEGROWTH = 10%)
 LOG ON
( NAME = N'_DBAMain_Log',
   FILENAME = N'C:\Logs\_DBAMain_Log.LDF' ,
   SIZE = 3072KB ,
   MAXSIZE = 2048GB ,
   FILEGROWTH = 10%)
GO
/*
   Run Script To Create Stored Procedures
   In _DBAMain
*/
sp_configure 'xp_cmdshell', 1
Reconfigure
exec xp_cmdshell 'sqlcmd -i C:\Writing\Create_DBAMain_2.sql'
-- Schedule Indexing Stored Procedure
/*
Usage:
spxCreateIDXMaintenanceJob
'Owner Name' , 'Operator' , 'Sunday' ,0
*/
Create Procedure
     [dbo].[spxCreateIDXMaintenanceJob]
   (
  @JobOwner
, @ValidOperator
, @DayToReindex
, @NightlyStartTime
(12pm)
)
As
BEGIN TRANSACTION
￼￼DECLARE
     @ReturnCode   INT
   , @jobId
   , @MyServer
   , @SQL
   , @CR
SELECT
BINARY(16)
   nvarchar(75)
 nvarchar(4000)
nvarchar(2)
     @ReturnCode = 0
   , @CR = char(13) + char(10)
IF NOT EXISTS   (
            SELECT
name FROM
                 msdb.dbo.syscategories
            WHERE
                 name = N'Database Maintenance'
            AND
                 category_class = 1
)
BEGIN
   EXEC @ReturnCode = msdb.dbo.sp_add_category
        @class = N'JOB'
      , @type = N'LOCAL'
      , @name = N'Database Maintenance'
IF
        @@ERROR <> 0
   OR
        @ReturnCode <> 0
   Begin
        GOTO QuitWithRollback
   End
END
IF EXISTS   (
         SELECT
name FROM
              msdb.dbo.sysjobs
         WHERE
              name = N'IDX Maintenance'
         AND
              category_id =   (
Select
category_id
From
                             msdb.dbo.syscategories
                        Where
name = 'Database Maintenance'
￼￼Begin
End
)
@job_name = 'IDX Maintenance'
                     )
Exec msdb.dbo.sp_delete_job
EXEC @ReturnCode = msdb.dbo.sp_add_job
           @job_name = N'IDX Maintenance'
         , @enabled = 1
         , @notify_level_eventlog = 0
         , @notify_level_email = 0
         , @notify_level_netsend = 0
         , @notify_level_page = 0
         , @delete_level = 0
         , @description = N'Index Tuning'
         , @category_name = N'Database Maintenance'
         , @owner_login_name = @JobOwner
         , @job_id = @jobId OUTPUT
IF
     @@ERROR <> 0
OR
     @ReturnCode <> 0
Begin
     GOTO QuitWithRollback
End
Select @SQL = 'exec spxIDXMaint '
                 + char(39) + @DayToReindex + char(39)
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep
           @job_id = @jobId
, @step_name = N'Index Maintenance'
, @step_id = 1
, @cmdexec_success_code = 0
, @on_success_action = 1
, @on_success_step_id = 0
, @on_fail_action = 2
, @on_fail_step_id = 0
, @retry_attempts = 0
, @retry_interval = 0
, @os_run_priority = 0
, @subsystem = N'TSQL'
, @command = @SQL
, @database_name = N'_DBAMain'
, @flags = 0
IF
     @@ERROR <> 0
OR
     @ReturnCode <> 0
     Begin
     GOTO QuitWithRollback
End
EXEC @ReturnCode = msdb.dbo.sp_update_job
           @job_id = @jobId
         , @start_step_id = 1
     @@ERROR <> 0
OR
     @ReturnCode <> 0
Begin
     GOTO QuitWithRollback
End
EXEC @ReturnCode = msdb.dbo.sp_update_job
     @job_id = @jobId
   , @notify_level_email = 2
   , @notify_level_netsend = 2
   , @notify_level_page = 2
   , @notify_email_operator_name = @ValidOperator
IF
     @@ERROR <> 0
OR
     @ReturnCode <> 0
Begin
     GOTO QuitWithRollback
End
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule
     @job_id = @jobId
   , @name = N'Nightly Index Tuning Schedule'
   , @enabled = 1
   , @freq_type = 4
   , @freq_interval = 1
   , @freq_subday_type = 1
   , @freq_subday_interval = 0
   , @freq_relative_interval = 0
   , @freq_recurrence_factor = 0
   , @active_start_date = 20080101
   , @active_end_date = 99991231
   , @active_start_time = @NightlyStartTime
   , @active_end_time = 235959
IF
     @@ERROR <> 0
OR
     @ReturnCode <> 0
Begin
GOTO QuitWithRollback
End
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver
     @job_id = @jobId
   , @server_name = N'(local)'
IF
     @@ERROR <> 0
OR
     @ReturnCode <> 0
Begin
     GOTO QuitWithRollback
End
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
   IF @@TRANCOUNT > 0
   Begin
        ROLLBACK TRANSACTION
   End
EndSave:
GO
--Create Index Maintenance Job
EXEC _dbaMain..spxCreateIDXMaintenanceJob
     'sa'
, 'sqlsupport' , 'Sunday' ,0
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
￼￼￼DECLARE @data XML,
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
SET @tsqlCommand =
EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]
','nvarchar(max)')
SET @eventType =
EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(ma
x)')
SET @serverName =
EVENTDATA().value('(/EVENT_INSTANCE/ServerName)[1]','nvarchar(m
ax)')
SET @loginName =
EVENTDATA().value('(/EVENT_INSTANCE/LoginName)[1]','nvarchar(ma
x)')
SET @userName =
EVENTDATA().value('(/EVENT_INSTANCE/UserName)[1]','nvarchar(max
)')
SET @databaseName =
EVENTDATA().value('(/EVENT_INSTANCE/DatabaseName)[1]','nvarchar
(max)')
SET @objectName =
EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(m
ax)')
SET @objectType =
EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]','nvarchar(m
ax)')
SET @emailBody = + '--------------------------------' +
CHAR(13)
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼CHAR(13)
CHAR(13)
CHAR(13)
CHAR(13)
+ '- DDL Trigger Activation Report      -' +
+ '--------------------------------------' +
+ 'Sql Command: '
    + ISNULL(@tsqlCommand, 'No Command Given') +
+ 'Event Type: '
    + ISNULL(@eventType, 'No Event Type Given') +
    
CHAR(13)
￼￼CHAR(13)
CHAR(13)
CHAR(13)
CHAR(13)
CHAR(13)
CHAR(13)
+ 'Server Name:
  ' + ISNULL(@serverName, 'No Server Given') +
+ 'Login Name: '
    + ISNULL(@loginName, 'No LOGIN Given') +
+ 'User Name: '
    + ISNULL(@username, 'No User Name Given') +
+ 'DB Name: '
    + ISNULL(@databaseName, 'No Database Given') +
+ 'Object Name: '
    + ISNULL(@objectName, 'No Object Given') +
+ 'Object Type: '
    + ISNULL(@objectType, 'No Type Given') +
+ '-------------------------------------------';
EXEC msdb..sp_send_dbmail @profile_name='Admin Profile',
@recipients='<yourmail@yourmail.com>, @subject='DDL Alteration
Trigger', @body=@emailBody
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
-- Turn configurations back off
sp_configure 'xp_cmdshell', 0
reconfigure
sp_configure 'Show Advanced Options', 0
Reconfigure
-- End Script
PRINT 'All Done...Add Server to DBA Repository for further
documentation'