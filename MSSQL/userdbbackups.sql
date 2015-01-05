EXECUTE dbo.DatabaseBackup
@Databases = 'USER_DATABASES',
@Directory = 'C:\dbbackups',
@BackupType = 'FULL',
@Verify = 'Y',
@Compress = 'Y',
@CheckSum = 'Y',
@CleanupTime = 24