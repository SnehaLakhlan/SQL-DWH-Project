/*
=========================================================================================
CREATING DATABASE AND SCHEMAS
  -Creates a new database named 'DataWarehouse'.
  -Sets up three schemas within the database: 'bronze', 'silver', and 'gold'.
==========================================================================================
*/

USE master;
GO

CREATE DATABASE DataWareHouse;
GO

USE DataWarehouse;
GO 

-- CREATING SCHEMAS

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
