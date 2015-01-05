--Setup Security Logging
--Enable Successful and Unsuccessful Login Attempts
--SQL Server Services must be restarted to take affect
exec master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'AuditLevel', REG_DWORD,3