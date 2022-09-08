/*
Data exploration is just a simplified scenario where you can understand the basic characteristics of your data
*/

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://datalakedemoaletu.dfs.core.windows.net/filesysdemoaletu/NYCTripSmall.parquet',
        FORMAT='PARQUET'
    ) AS [result]
;
GO
