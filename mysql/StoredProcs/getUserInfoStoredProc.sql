PROCEDURE `GetUserInfo`()
BEGIN
SELECT user, host, password
FROM mysql.user;
END'