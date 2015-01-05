USE hs_rets_dev
GO

SELECT city, original_listing_price
FROM dbo.final_az_properties
WHERE original_listing_price != 80.99
GO
   AND CONTAINS(city, 'Phoenix')