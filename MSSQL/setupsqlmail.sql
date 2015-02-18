--Setup Database Mail (SQL Server > 2005 )
--Turn on Mail XPs via sp_configure
sp_configure 'show advanced options',1
GO
RECONFIGURE WITH OVERRIDE
GO
sp_configure 'Database Mail XPs',1
GO
RECONFIGURE 
-- Add Profile
If @@microsoftversion / power(2, 24) > 8
BEGIN
EXECUTE msdb.dbo.sysmail_add_profile_sp
       @profile_name = 'Default',
       @description = 'Default Profile For Alerts' ;
--Add Mail Account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'Admin Account',
    @description = 'General SQL Admin Account for DBA Notification',
    @email_address = 'SQLAdmin@iridium.com',
    @display_name = 'SQL Admin Account SeverName',
    @mailserver_name = 'istexgw1.isllc.local';
--Add Mail Account to Profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Admin Profile',
    @account_name = 'Admin Account',
    @sequence_number = 1 ;
--Send Test Mail
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Admin Profile',
    @recipients = 'SQLGroup@iridium.com',
    @body = 'Sever Mail Configuration Completed',
    @subject = 'Successful Mail Test';
END ELSE