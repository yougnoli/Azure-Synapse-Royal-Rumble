/*
You can browse the content of the files directly via *master* database. 
For some simple data exploration scenarios, you don't need to create a separate database. However, as you continue data exploration, you might want to create some utility objects, such as:
- External data sources that represent the named references for storage accounts.
- Database scoped credentials that enable you to specify how to authenticate to external data source.
- Database users with the permissions to access some data sources or database objects.
- Utility views, procedures, and functions that you can use in the queries.
*/

-- create a separate database for custom database objects, because customd database objects cannot be created in the master database
CREATE DATABASE DataExplorationDB 
                COLLATE Latin1_General_100_BIN2_UTF8
;
GO

-- Switch from master to DataExplorationDB
USE DataExplorationDB
;
GO

-- Create utility objects such as data source
CREATE EXTERNAL DATA SOURCE DemoLake
WITH ( LOCATION = 'https://datalakedemoaletu.dfs.core.windows.net')
;
GO

-- Create a login for a user in DataExplorationDB that will access external data
CREATE LOGIN data_explorer WITH PASSWORD = 'type a password'
;
GO

-- create a user in 'DataExplorationDB' for the above login and grant the ADMINISTER DATABASE BULK OPERATIONS permission
CREATE USER data_explorer FOR LOGIN data_explorer
;
GO
GRANT ADMINISTER DATABASE BULK OPERATIONS TO data_explorer
;
GO

-- Explore the content of the file
SELECT
    TOP 100 *
FROM
    OPENROWSET(
            BULK '/filesysdemoaletu/NYCTripSmall.parquet',
            DATA_SOURCE = 'DemoLake',
            FORMAT='PARQUET'
    ) AS [result]
;
GO
