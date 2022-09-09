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

# Serverless vs Dedicated

## Computation:
 - **Serverless** means that the compute associated with a SQL poll is managed and allocated by Microsoft. In this way customers do not have to create or allocate compute to query data that is located in the underlying Data Lake. This data can be *structured* or *unstructured*, stored in different *file formats*. No need to cluster configuration.
 - **Dedicated** means that the user has to configure performance level (measured in *Data Warehouse Units (DWU)*) and manage the scalability of the resource. It needs to set up an infrastructure.
 
## Storage:
 - **Serverless** points directly to the Data Lake. Data stay in the Data Lake. It is possible to create a *Logical DWH* over the Data Lake, without moving, transforming and relocating data.
 - **Dedicated** provides data storage in a relational table with *columnar* storage: it improves query performance and limits the storage costs
 
## Costs:
 - **Serverless** is a pay per use model: there is no costs for resources not used (5$/TB). The charge is based on data processed by each run of the query 
 - **Dedicated** the user pays for reserved resources at a pre decided scale. It is pausable, when is turned off there no costs
  
## Use Cases:
 - **Serverless** is used for ad-hoc querying, exploratory data analysis, initial analysis before the ETL development
 - **Dedicated** is built for specific workloads where is needed performance, optimized compute startegy and persisted data warehouses
