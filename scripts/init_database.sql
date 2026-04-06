/*

=========================================================================================
CREATE DATABASE AND SCHEMAS
=========================================================================================

PURPOSE:

This script helps create a fresh database 'DataWareHouse' in SQLServer from scratch after checking if it exists.
If the database exists, it will drop and recreate the same database. 
In addition to this, we are creating or setting up three schemas within the database: 'bronze', 'silver', 'gold'.
The schemas represent different data layers in our data warehouse design.

NOTE: 
Running this script will drop the existing 'DataWareHouse' database along with all its data, tables and schemas. 
Make sure you have proper backups before executing it.

*/

========================================================================================================================================================================
========================================================================================================================================================================


USE MASTER;
GO

-----------------------------------------------
--Drop & Recreate the 'DataWareHouse' database'
-----------------------------------------------

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO


----------------------------------------
--Creating the 'DateWareHouse' database
----------------------------------------

CREATE DATABASE DataWareHouse;
GO

USE DataWareHouse;
GO

-------------------------
--Creating the Schemas
-------------------------

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO







