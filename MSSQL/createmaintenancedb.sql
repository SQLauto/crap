--Create Maintenance Database "_DBAMain"
USE [master]
GO
/****** Object:  Database [_DBAMain]
                  Script Date: 02/05/2009 20:41:24 ******/
                  IF  EXISTS (SELECT name FROM sys.databases
              WHERE name = N'_DBAMain')
DROP DATABASE [_DBAMain]
GO
/****** Object:  Database [_DBAMain]
                  Script Date: 02/05/2009 20:41:24 ******/
CREATE DATABASE [_DBAMain] ON  PRIMARY
( NAME = N'_DBAMain_Data',
   FILENAME = N'C:\DB\_DBAMain_Data.MDF',
   SIZE = 5120KB,
   MAXSIZE = UNLIMITED,
   FILEGROWTH = 10%)
 LOG ON
( NAME = N'_DBAMain_Log',
   FILENAME = N'C:\logs\sql\_DBAMain_Log.LDF' ,
   SIZE = 3072KB ,
   MAXSIZE = 2048GB ,
   FILEGROWTH = 10%)
GO