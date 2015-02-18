SELECT SUBSTRING_INDEX(host, ':', 1) AS host_short, 
	GROUP_CONCAT(DISTINCT USER)   AS users, 
	COUNT(*) 
FROM   information_schema.processlist 
GROUP  BY host_short 
ORDER  BY COUNT(*), 
	host_short;