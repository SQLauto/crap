/* 

Auditing a database for deletes and changes to tables, stored procedures, views and functions

*/

-- Build the audit table
   
CREATE TABLE Event
(
  Login NVARCHAR(100),
  Time DATETIME,  
  Type NVARCHAR(100),
  Code NVARCHAR(500)  
)
GO


-- Build the trigger only for drops and alters

CREATE TRIGGER DropAlterAudit 
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE, 
    DROP_PROCEDURE, ALTER_PROCEDURE,
    DROP_VIEW, ALTER_VIEW,
    DROP_FUNCTION, ALTER_FUNCTION
AS
DECLARE @Data XML
SET @Data = EventData()
INSERT Event (Login, Time, Type, Code)
SELECT @Data.value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(100)'),
       @Data.value('(/EVENT_INSTANCE/PostTime)[1]', 'nvarchar(100)'),       
       @Data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
       @Data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(500)');
GO
