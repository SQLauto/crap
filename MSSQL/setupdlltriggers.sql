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
 
EXEC msdb..sp_send_dbmail @profile_name='Admin Profile', @recipients='jmallory@hsmove.com, @subject='DDL Alteration Trigger', @body=@emailBody
 
GO
 
SET ANSI_NULLS OFF
GO
 
SET QUOTED_IDENTIFIER OFF
GO
 
ENABLE TRIGGER [AuditDatabaseDDL] ON ALL SERVER
GO