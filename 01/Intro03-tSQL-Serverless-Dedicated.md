# tSQL features supported in Azure Synapse SQL
Azure Synapse SQL is a big data analytic service that enables you to query and analyze your data using the tSQL language.
Transact-SQL is used in *serverless SQL pool* and *dedicated* model, but there are some differences in the set of supported features and different objects you can/cannot create in one engine or another.

## Database objects

|   | Dedicated | Serverless |
| --- | --- | --- |
| **Tables** | Yes | No, it can query only *external tables*, that reference data stored in Data Lake |
| **Views** | Yes | Yes |
| **Schemas** | Yes | Yes |
| **Stored procedure** | Yes | Yes, not placed in *master* database |
| **User defined functions** | Yes | Yes, only inline table valued functions |
| **External tables** | Yes | Yes |
| **Caching queryies** | Yes | No, only file statistics are cached |
| **Materialized Views** | Yes | No |
| **Distributions** | Yes | No |
| **Partitions** | Yes | No, but you can partition tables in Spark. Those tables will be synchronized with serverless SQL pool |
| **Indexes** | Yes | No |
| **Statistics** | Yes | Yes |
| **Worhload managment** | Yes | No, you cannot manage the resources, serverless SQL pool automatically do that |
| **Cost control** | Yes | Yes |

## Query Language

|   | Dedicated | Serverless |
| --- | --- | --- |
| **SELECT** | Yes | Yes |
| **INSERT** | Yes | No. For upload new data in the Data Lake use Spark, or create an *external table* using **CETAS** and insert data |
| **UPDATE** | Yes | No. Update Parquet/CSV data using Spark and the changes will be automatically available in the serverless pool |
| **DELETE** | Yes | No. Delete Parquet/CSV data using Spark and the changes will be automatically available in the serverless pool |
| **MERGE** | Yes | No. Merge Parquet/CSV data using Spark and the changes will be automatically available in the serverless pool |
| **CETAS** | Yes | Yes |
| **Labels** | Yes | No, only file statistics are cached |
| **Data Load** | Yes | No, you cannot load data into the serverless SQL pool because data is stored on external storage |
| **Data Export** | Yes, using CETAS | Yes, using CETAS |
















