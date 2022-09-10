/*
Full tutorial available on: https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/tutorial-data-analyst
In this tutorial, you learn how to perform exploratory data analysis by combining different Azure Open Datasets 
using serverless SQL pool and then visualizing the results in Azure Synapse Studio.

In particular, you analyze the New York City (NYC) Taxi dataset that includes:

 - Pickup and drop-off dates and times.
 - Pick up and drop-off locations.
 - Trip distances.
 - Itemized fares.
 - Rate types.
 - Payment types.
 - Driver-reported passenger counts.*/


/*
 * * * * * * * * * * * * * * * *
 * Automatic schema inference  *
 * * * * * * * * * * * * * * * *

Since data is stored in the Parquet file format, automatic schema inference is available. You can easily query the 
data without listing the data types of all columns in the files. You also can use the virtual column mechanism and 
the filepath function to filter out a certain subset of files.

Let's first get familiar with the NYC Taxi data by running the following query. */

select top 100
	*
from	
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/puYear=*/puMonth=*/*.parquet'
		,format='parquet'
	) as nyc
;
go

select
	count(*) as num_rows
from	
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/puYear=*/puMonth=*/*.parquet'
		,format='parquet'
	) as nyc
;
go -- 1,571,671,152

/* Similarly, you can query the Public Holidays dataset by using the following query. */

select top 100
	*
from	
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/holidaydatacontainer/Processed/*.parquet'
		,format='parquet'
	) as holidays
where
	countryOrRegion = 'italy' and year([date]) = 2016
;
go

/* Lastly, you can also query the Weather Data dataset by using the following query. */

select top 100
	*
from	
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/isdweatherdatacontainer/ISDWeather/year=*/month=*/*.parquet'
		,format='parquet'
	) as weather
;
go

/*
 * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Time series, seasonality, and outlier analysis  *
 * * * * * * * * * * * * * * * * * * * * * * * * * *
You can easily summarize the yearly number of taxi rides by using the following query. */

select
    year(tpepPickupDateTime) AS current_year
    ,count(*) as rides_per_year
from	
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/puYear=*/puMonth=*/*.parquet'
		,format='parquet'
	) as nyc
where 
	nyc.filepath(1) >= '2009' AND nyc.filepath(1) <= '2019'
group by 
	year(tpepPickupDateTime)
order by 
	year(tpepPickupDateTime)
;
go

/* The data can be visualized in Synapse Studio by switching from the Table to the Chart view.
You can choose among different chart types, such as Area, Bar, Column, Line, Pie, and Scatter.
In this case, plot the Column chart with the Category column set to current_year.

From this visualization, a trend of a decreasing number of rides over years can be clearly seen.
Presumably, this decrease is due to the recent increased popularity of ride-sharing companies.
*/

/* Next, let's focus the analysis on a single year, for example, 2016.
The following query returns the daily number of rides during that year. */

select
    convert(date, [tpepPickupDateTime]) as [current_day]
    ,count(*) as rides_per_day
from	
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/puYear=*/puMonth=*/*.parquet'
		,format='parquet'
	) as nyc
where 
	nyc.filepath(1) = '2016'
group by 
	convert(date, [tpepPickupDateTime])
order by 
	convert(date, [tpepPickupDateTime])
;
go

/* Again, you can easily visualize data by plotting the Column chart with
the Category column set to current_day and the Legend (series) column set to rides_per_day. */

/* From the plot chart, you can see that there's a weekly pattern, with Saturdays as the peak day.
During summer months, there are fewer taxi rides because of vacations.
There are also some significant drops in the number of taxi rides without a clear pattern of when and why they occur. */

/* Next, let's see if the drops correlate with public holidays by joining the NYC Taxi rides dataset with the Public Holidays dataset. */

with taxi_rides as
(
	select
		convert(date, [tpepPickupDateTime]) as [current_day]
		,count(*) as rides_per_day
	from	
		openrowset(
			bulk 'https://azureopendatastorage.blob.core.windows.net/nyctlc/yellow/puYear=*/puMonth=*/*.parquet'
			,format='parquet'
		) as nyc
	where 
		nyc.filepath(1) = '2016'
	group by 
		convert(date, [tpepPickupDateTime])
),
public_holidays AS
(
    select
        holidayname as holiday
        ,convert(date, [date]) as [date]
	from	
		openrowset(
			bulk 'https://azureopendatastorage.blob.core.windows.net/holidaydatacontainer/Processed/*.parquet'
			,format='parquet'
		) as holidays
	where
		countryorregion = 'United States' and year([date]) = 2016
)
select
	*
from 
	taxi_rides as a
	left outer join
	public_holidays as b 
	on a.current_day = b.[date]
order by 
	current_day
;
go

/* This time, we want to highlight the number of taxi rides during public holidays.
For that purpose, we choose none for the Category column and rides_per_day and holiday as the Legend (series) columns. */

/* From the plot chart, you can see that during public holidays the number of taxi rides is lower.
There's still one unexplained large drop on January 23. Let's check the weather in NYC on that day by querying the Weather Data dataset. */

select
	*
from
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/isdweatherdatacontainer/ISDWeather/year=*/month=*/*.parquet'
		,format='parquet'
	) as weather
where 
	countryorregion = 'US' and convert(date, [datetime]) = '2016-01-23' and stationname = 'JOHN F KENNEDY INTERNATIONAL AIRPORT'
;
go

select
    avg(windspeed)		as avg_windspeed
    ,min(windspeed)		as min_windspeed
    ,max(windspeed)		as max_windspeed
    ,avg(temperature)	as avg_temperature
    ,min(temperature)	as min_temperature
    ,max(temperature)	as max_temperature
    ,avg(sealvlpressure) as avg_sealvlpressure
    ,min(sealvlpressure) as min_sealvlpressure
    ,max(sealvlpressure) as max_sealvlpressure
    ,avg(precipdepth)	as avg_precipdepth
    ,min(precipdepth)	as min_precipdepth
    ,max(precipdepth)	as max_precipdepth
    ,avg(snowdepth)		as avg_snowdepth
    ,min(snowdepth)		as min_snowdepth
    ,max(snowdepth)		as max_snowdepth
from
	openrowset(
		bulk 'https://azureopendatastorage.blob.core.windows.net/isdweatherdatacontainer/ISDWeather/year=*/month=*/*.parquet'
		,format='parquet'
	) as weather
where 
	countryorregion = 'US' and convert(date, [datetime]) = '2016-01-23' and stationname = 'JOHN F KENNEDY INTERNATIONAL AIRPORT'
;
go

/* The results of the query indicate that the drop in the number of taxi rides occurred because:

1. There was a blizzard on that day in NYC with heavy snow (~30 cm).
2. It was cold (temperature was below zero degrees Celsius).
3. It was windy (~10 m/s). */


/* This tutorial has shown how a data analyst can quickly perform exploratory data analysis, easily combine different
datasets by using serverless SQL pool, and visualize the results by using Azure Synapse Studio. */
