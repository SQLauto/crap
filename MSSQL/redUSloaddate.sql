/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 100000 [org_id]
      ,[in_load_date]
      ,[in_modify_date]
  FROM [US].[dbo].[data_common_onmarket]
  WHERE org_id = 'caclaw' ORDER BY in_load_date