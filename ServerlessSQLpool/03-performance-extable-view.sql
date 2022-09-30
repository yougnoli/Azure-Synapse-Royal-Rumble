-- comparing results:

-- external table
SELECT * 
FROM dbo.QuarterlySales --> 1 sec

-- view
SELECT *
FROM dbo.vw_QuarterlySales_2013 --> 5 sec
