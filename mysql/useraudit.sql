DELIMITER //
CREATE PROCEDURE mysql.UserAudit()
BEGIN
SELECT NOW() as `time`, user, host 
FROM mysql.user;
END //
DELIMITER ;