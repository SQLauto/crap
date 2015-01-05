-- Unix time
DECLARE @unixtime BIGINT, @n, @c -- Must be BIGINT

SELECT @n = DATEADD(SECOND, @unixtime, {d '1970-01-01'}) 
SELECT @c = DATEADD(HOUR,-6,@n) NonUnixTime -- Adj CST
