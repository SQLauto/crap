EXECUTE dbo.DatabaseBackup
@Databases = 'USER_DATABASES',
@Directory = 'Z:\Backups',
@BackupType = 'FULL',
@Verify = 'Y',
@Compress = 'Y',
@CheckSum = 'Y',
@CleanupTime = 72