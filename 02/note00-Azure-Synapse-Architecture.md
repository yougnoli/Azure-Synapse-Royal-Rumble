# Azure Synapse SQL Architecture
Synapse SQL is based on a scale out architecture to **distribute** computational processing of data across **multiple nodes**. Compute is separate from storage, which enables you to scale compute independently of the data stored in your system. Synapse SQL uses a node-based architecture. Applications connect and issue T-SQL commands to a **Control node**, which is the single point of entry for Synapse SQL. The Azure Synapse SQL Control node utilizes a distributed query engine to optimize queries for **parallel processing**, and then passes operations to **Compuye nodes** to do thei work in parallel. The Compute nodes provide the computational power.

For **dedicated SQL pool**, the unit of scale is known as *data warehouse units (DWU)*.

For **serverless SQL pool**, being serverless, scaling is done automaticallyto accomodate query resource requirements. It adapts to change and it makes sure your query has enough resources to finish successfully.

## Serverless Architecture
Serverless SQL pool **Control node** utilizes **Distributed Query Processing (DQP)** engine by **splitting** the user query in smaller pieces that will be executed on **Compute nodes**. Compute nodes read files from storage, join results and give results back to the Control node.
![image](https://user-images.githubusercontent.com/77077281/189526925-e1e73e92-5ee5-4121-ae4f-862d6c2efe20.png)

Serverless SQL pool allows you to query your data lake files, without moving them.

## Dedicated Architecture
This image shows dedicated SQL pool utilizing **4 compute nodes** to execute a query.
When you submit a tSQL query to dedicated SQL pool, the Control node transforms it into queries that run against each distribution in parallel. The number of **compute nodes ranges from 1 to 60**, and is determined by the service level for the dedicated SQL pool.
![image](https://user-images.githubusercontent.com/77077281/189526706-e44ea685-8ea9-421f-a0b9-0440364479e0.png) 
The Data Movement Service (DMS) is a system-level internal service that moves data across the nodes as necessary to run queries in parallel and return accurate results.

Dedicated SQL pool allows you to query and ingest data from your data lake files. When data is ingested into dedicated SQL pool, the data is sharded into **distributions** to optimize the performance of the system. You can choose which tipe of fragmentation pattern to use to distribute the data when you define the table. These fragmentations patterns are supported:
 - Hash
 - Round Robin
 - Replicate

### Hash-distributed tables
This type of table can deliver the highest query performance for **joins** and **aggregations** on large tables. Dedicated SQL pool uses a **hash function** to assign each row to one distribution. A column is passed inside the hash function and that is designated as the distribution column. The values of the distribution column are used to distribute rows into the different distributions.
![image](https://user-images.githubusercontent.com/77077281/189527846-cc520805-495e-4a6a-84e9-8a1aa4eb13a1.png)
 - Each row belongs to one distribution.
 - A hash algorithm assigns each row to one distribution. 
 - Number of table rows per distributions differs by the different size of tables. 

### Round-Robin distributed tables
A round-robin table is the simplest table to create and delivers fast performance when used as a staging table for loads.
A round-robin distributed table distributes data evenly across the table but without any further optimization.
Query performance can often be better with hash distributed tables: joins on round-robin tables require reshuffling data, which takes additional time.

### Replicated tables
A replicated table provides the fastest query performance for small tables.
![image](https://user-images.githubusercontent.com/77077281/189528622-104e239c-3dce-43f2-9870-de29c2379238.png)

A table that is replicated caches a full copy of the table on each compute node. So, replicating a table removes the need to transfer data among compute nodes before a join or aggregation. Replicated tables are best utilized with small tables.

