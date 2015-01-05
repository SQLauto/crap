/* 

Calculates the mode of a data set 

*/

SELECT TOP 1 OurValue
  , COUNT(*) Mode
FROM OurTable
GROUP BY OurValue
ORDER BY COUNT(*) DESC
