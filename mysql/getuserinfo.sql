DELIMITER //
CREATE PROCEDURE mysql.GetUserInfo(IN userName VARCHAR(255))
BEGIN
SELECT user, host, password
FROM mysql.user;
END //
DELIMITER ;