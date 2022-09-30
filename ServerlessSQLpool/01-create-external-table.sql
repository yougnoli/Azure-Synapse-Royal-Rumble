CREATE DATABASE DataExplorationDB 
                COLLATE Latin1_General_100_BIN2_UTF8
;
GO

CREATE CREDENTIAL [https://asadatalake754874.dfs.core.windows.net]
WITH IDENTITY='User Identity'
;
GO

-- Switch from master to DataExplorationDB
USE DataExplorationDB
;
GO

-- Create a login for a user in DataExplorationDB that will access external data
CREATE LOGIN data_explorer WITH PASSWORD = 'Pippo2022!'
;
GO

-- create a user in 'DataExplorationDB' for the above login and grant the ADMINISTER DATABASE BULK OPERATIONS permission
CREATE USER data_explorer FOR LOGIN data_explorer
;
GO
GRANT ADMINISTER DATABASE BULK OPERATIONS TO data_explorer
;
GO


-- create external data source
CREATE EXTERNAL DATA SOURCE WwiDataADLS
WITH (LOCATION = 'abfss://wwi@asadatalake754874.dfs.core.windows.net') 
;
GO

-- create external file format
CREATE EXTERNAL FILE FORMAT CsvFormat
WITH ( 
    FORMAT_TYPE = DELIMITEDTEXT, 
    FORMAT_OPTIONS ( FIELD_TERMINATOR = ',', STRING_DELIMITER = '"')
)
;
GO

-- create external table
CREATE EXTERNAL TABLE QuarterlySales
WITH (
    LOCATION = 'quarterly-sales',    -- new folder where the data are stored
    DATA_SOURCE = WwiDataADLS,
    FILE_FORMAT = CsvFormat    -- new file format of the stored data
)
AS
    -- query
    SELECT 
        InvoiceYear,
        InvoiceQuarter,
        Sum(cast([Quantity] as int)) as SalesQuantity
    FROM
        OPENROWSET(
            BULK 'https://asadatalake754874.dfs.core.windows.net/wwi/factsale-deltalake',
            FORMAT = 'DELTA'
        ) AS [result]
    WHERE InvoiceYear=2012
    GROUP BY
        InvoiceYear,
        InvoiceQuarter
;
GO

-- now check on the DataLake for the new folder in asadatalake754874wwi/quarterly-sales 
-- and you will see the csv file with the data from the external table

-- check query on the external table
SELECT * 
FROM dbo.QuarterlySales
