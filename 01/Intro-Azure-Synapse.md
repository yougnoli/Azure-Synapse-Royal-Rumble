# Introduction to Azure Synapse

## What is
Azure Synapse Analytics is a set of services in the field of data analysis, data engineering and machine learning. Brings together the best of:
- **SQL** technologies used in enterprise *data warehousing*
- **Spark** technologies used for *big data*
- **Data Explorer** for log and time series analytics
- **Pipelines** for *data integration* and *ETL/ELT*
- deep integration with other **Azure Services** such as:
    - Power BI
    - Cosmos DB
    - Azure ML
 
Formerly was known as *Azure SQL Data Warehouse*, but is not a mere Data Warehouse anymore. Itprovides two different types of compute environments for different workloads:
 - SQL Compute Environment
 - Spark Compute Environment.

## Synapse SQL
Is a *distributed* query system for tSQL that enables data warehousing and data virtualization scenarios. Moreover extends tSQL to address streaming analytics and machine learning scenarios.
Synapse SQL offers two types **data processing systems**:
 - Serverless
 - Dedicated

Synapse SQL can use built-in streaming capabilities to land data from cloud to SQL tables. Can also integrate AI with SQL by using machine learning models using the [tSQL PREDICT function](https://docs.microsoft.com/en-us/sql/t-sql/queries/predict-transact-sql?view=azure-sqldw-latest&preserve-view=true).

## Apache Spark for Azure Synapse
Apache Spark is the most popular open source big data engine used for data preparation, data engineering, ETL and machine learning.

## Working with Data Lake
With Azure Synapse you can mix together SQL and Spark: they can directly explore and analyze Parquet, CSV, TSV, and JSON files stored in the data lake.

## Built in data integration
Azure Synapse contains the same Data Integration engine and experiences as Azure Data Factory, allowing you to create rich at-scale ETL pipelines without leaving Azure Synapse Analytics.


All of this because Synapse provides a unified portal called **Synapse Studio** for developers to build solutions, mantain, and secure all in a single environment.  
























