EXECUTE dbo.DatabaseBackup
@Databases = 'ALL_DATABASES',
@Directory = 'Z:\Backups',
@BackupType = 'FULL',
@Verify = 'Y',
@Compress = 'Y',
@CheckSum = 'Y',
@CleanupTime = 24