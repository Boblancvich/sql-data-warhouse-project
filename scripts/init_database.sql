/* 
Script Purpose - Create a new database called DataWarehouse after checking it already exists. 
If it exists, drop and recreate it.
The script sets up three schemas within the database - bronze, silver and gold.

WARNING - Running this script will drop the entire DataWarehousing database if it exists. 
All data in the database will pe permanently deleted. Exercise caution and ensure you maintain an
up-to-date backup before running the script. 
*/


USE master;
Go

-- Drop and recreate DataWarehouse Db
-- return true if a DB called DataWarehosue is found. If it is found, delete it.
IF EXISTS (SELECT 1 FROM sys.databases where name = 'DataWarehouse')
	BEGIN
		ALTER DATABASE DataWarehouse SET SINGLE_USER with ROLLBACK IMMEDIATE;
		DROP DATABASE DataWarehouse;
	END;
	GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse; /* Use the database we create */
GO
--
CREATE SCHEMA bronze; /* Creates rules for each layer */
Go
CREATE SCHEMA silver;
Go
CREATE SCHEMA gold;
Go
