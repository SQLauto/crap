-- Schedule Indexing Stored Procedure
 
/*
Usage:
spxCreateIDXMaintenanceJob
     'Owner Name'
   , 'Operator'
   , 'Sunday'
   , 0
*/
Create Procedure
     [dbo].[spxCreateIDXMaintenanceJob]
   (
     @JobOwner      nvarchar(75)
   , @ValidOperator      nvarchar(50)
   , @DayToReindex       nvarchar(8)
   , @NightlyStartTime   int --230000 (11pm), 0 (12am), 120000 (12pm)
   )
As
BEGIN TRANSACTION
 
DECLARE
     @ReturnCode   INT
   , @jobId   BINARY(16)
   , @MyServer   nvarchar(75)
   , @SQL      nvarchar(4000)
   , @CR      nvarchar(2)
 
SELECT
     @ReturnCode = 0
   , @CR = char(13) + char(10)
 
IF NOT EXISTS   (
            SELECT
                 name
            FROM
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
              name
         FROM
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
                        )
         )
Begin
   Exec msdb.dbo.sp_delete_job
        @job_name = 'IDX Maintenance'
End
 
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
 
IF
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