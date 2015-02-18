 DELETE FROM gtocdr.ecdrsmall 
 WHERE DateTimeForStartOfCharge < '2011-07-01 00:00:00' 
 ORDER BY DateTimeForStartOfCharge ASC 
 LIMIT 1000000;