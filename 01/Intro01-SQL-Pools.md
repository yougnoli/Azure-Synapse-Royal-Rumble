# How Azure Synapse Analytics works
Azure Synapse Analytics acts as an integrated environment to meet all your analytical needs.

Azure Synapse SQL is a **distributed** query system that enables you to implement *data warehousing* and *data virtualization* scenarios using tSQL.
Synapse SQL offers both **serverless** and **dedicated** resource models to work with both *descriptive* and *diagnostic* analytical scenarios.

#### Descriptive Analytics
Answwer the question *What is happening in my business?*. The data to answer this question is tipically answered through the creation of a **data warehouse**. The **dedicated SQL pool** is a resource that enables you to create a persisted data warehouse to perform this type of analysis. For predicatble performance and cost, create a dedicated SQL pool to give processing power for data stored in SQL tables.

#### Diagnostic Analytics
Deals with answering the question *Why is it happening?*. This may involve exploring information that already exists in the data warehouse. You can use the **serverless SQL pool** to interactively explore data within a datalake. For unplanned or ad-hoc workloads, use the always available serverless SQL endpoint.

## Serverless SQL Pool
Every Azure Synapse Analytics at the moment of creation comes with serverless SQL pool endpoint that you can use to query data in the Azure Data Lake, Cosmos DB or Dataverse. Serverless SQL pool is a query service **over** the data in your Data Lake. Is a **distributed** data processing system, built for large scale data and computational functions. Serverless SQL pool is serverless, hence there's no infrastructure to setup or clusters to maintain.

There is no charge for resources reserved, you are only being charged for the data processed by queries you run, hence this model is a true pay-per-use model (5$ / TB processed).

If you use **Apache Spark** for Azure Synapse in your data pipeline, for data preparation, cleansing or enrichment, you can query external Spark tables you've created in the process, directly from serverless SQL pool.

Note: some aspects of tSQL language are not supported due to the design of serverless SQL pool:
 - DDL (Data Definition Language) statements related to **view** and **security** only
 - DML (Data Manipulation Language) statements
 - No Tables, Triggers, Materialized Views because has not local storage, only metadata objects can be stored

### Serverless SQL pool benefits:
 - Basic discovery and exploration: (Parquet, JSON, CSV)
 - [Logical data warehouse](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/tutorial-logical-data-warehouse): create a relational abstraction on top of raw data without relocating and transforming them
 - Data transformation: transform data in the lake using tSQL, so it can be fed to BI or other tools
 
### Different professional roles can benefit from it:
 - Data Engineers: explore the lake, transform and prepare data through pipelines
 - Data Scientists: build machine learning models through Apache Spark
 - Data Analysts: can explore data and Spark external table using tSQL or other language
 - BI Professionals: can quickly create Power BI report on top of data in the lake or Spark tables


## Dedicated SQL Pool








































