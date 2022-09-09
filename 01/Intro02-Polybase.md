# PolyBase
PolyBase enables your SQL Server instance to query data with tSQL directly from another server, database, object storage without separetly installing client connection software. PolyBase allows tSQL queryies to join the data from external sources to relational tables in an istance of SQL Server.

It is called **data virtualization** because PolyBase allow the data to stay in its original location and format. You can virtualize the external data through the SQL Server instance, so that it can be queried in place like any other table in SQL Server. This process **minimizes the need for ETL processes** for data movement. This data virtualization scenario is possible with the use of PolyBase connectors.

PolyBase enables Azure Synapse Analytics to import and export data fromAzure Data Lake.

https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/load-data-overview
