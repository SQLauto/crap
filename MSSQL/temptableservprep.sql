--Create Temp table #SerProp. This table will be used
--to hold the output of xp_msver to control server property configurations

SET NOCOUNT ON
GO
IF EXISTS ( SELECT  name
            FROM    tempdb..sysobjects
            Where   name like '#SerProp%' )
--If So Drop it
    DROP TABLE #SerProp
create table #SerProp
(
ID int,
      Name sysname,
      Internal_Value int,
      Value nvarchar(512)
)
GO