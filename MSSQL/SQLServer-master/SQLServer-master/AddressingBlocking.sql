DECLARE @cnt INT
SELECT @cnt = COUNT(w.blocking_session_id)  FROM sys.dm_tran_locks t  INNER JOIN sys.dm_os_waiting_tasks w ON t.lock_owner_address = w.resource_address


IF @cnt > 25
BEGIN
	-- Blocking Process
END
