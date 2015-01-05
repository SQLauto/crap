-- Function Example: Provides the circumference of a circle
CREATE FUNCTION Circumference (@diameter DECIMAL(10,4))
RETURNS DECIMAL(10,5)
AS 
BEGIN
	RETURN(PI() * @diameter)
END
-- Answer
SELECT dbo.Circumference(3)
-- Stock Rater Example
CREATE FUNCTION StockRate (@PE DECIMAL(5,2),@Dividend DECIMAL(5,4),@aTOl DECIMAL(5,2))
RETURNS DECIMAL(10,5)
AS
BEGIN
	RETURN ((1/@PE)* 10) + (@Dividend * 10) + (@aTOl * 10)
END
-- Rate this stock
SELECT dbo.StockRate(4,0.12,1)