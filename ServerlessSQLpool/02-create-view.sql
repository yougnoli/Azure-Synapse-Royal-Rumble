-- Switch from master to DataExplorationDB
USE DataExplorationDB
;
GO

CREATE VIEW dbo.vw_QuarterlySales_2013 
AS
    SELECT 
        InvoiceYear,
        InvoiceQuarter,
        Sum(cast([Quantity] as int)) as SalesQuantity
    FROM
        OPENROWSET(
            BULK 'https://asadatalake754874.dfs.core.windows.net/wwi/factsale-deltalake',
            FORMAT = 'DELTA'
        ) AS [result]
    WHERE InvoiceYear=2013
    GROUP BY
        InvoiceYear,
        InvoiceQuarter 
;
GO

-- check
SELECT *
FROM dbo.vw_QuarterlySales_2013 
