--Set Show Advanced Option
sp_configure 'Show Advanced Options', 1
Reconfigure
GO
DECLARE @PhysMem int
DECLARE @ProcType int
DECLARE @MaxMem int
INSERT  INTO #SerProp
        Exec xp_msver
Select  @PhysMem = Internal_Value
from    #SerProp
where   Name = 'PhysicalMemory'
Select  @ProcType = Internal_Value
from    #SerProp
where   Name = 'ProcessorType'
--Set Memory Configuration from server properties
--(memory level and processortype)
If @PhysMem > 4096 AND @ProcType = 8664
BEGIN
   SET @MaxMem = @PhysMem - 3072
   EXEC sp_configure 'max server memory', @MaxMem
   Reconfigure
END
ELSE
IF @PhysMem > 4096 AND @ProcType <> 8664
BEGIN
   SET @MaxMem = @PhysMem - 3072
   EXEC sp_configure 'awe enabled', 1
   Reconfigure
   EXEC sp_configure 'max server memory', @MaxMem
   Reconfigure
END