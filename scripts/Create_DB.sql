-- the purpose : to create the database and the schemas for the DWH project
-- Connect to the master database first
USE master;
GO

-- Drop the database if it already exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'datawarehouse')
BEGIN
    DROP DATABASE datawarehouse;
END
GO

-- Create the new data warehouse database
CREATE DATABASE datawarehouse;
GO

-- Switch context to the new database
USE datawarehouse;
GO

-- Drop schemas if they already exist
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    DROP SCHEMA bronze;
END
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    DROP SCHEMA silver;
END
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    DROP SCHEMA gold;
END
GO

-- Create schemas for each data layer
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
