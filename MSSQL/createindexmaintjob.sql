--Create Index Maintenance Job
 
EXEC _dbaMain..spxCreateIDXMaintenanceJob
     'sa'
   , 'sqlsupport'
   , 'Sunday'
   , 0