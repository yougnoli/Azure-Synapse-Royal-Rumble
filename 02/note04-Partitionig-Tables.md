# Partitioning tables in dedicated SQL pool
Using table partitions in dedicated SQL pool

Table partitions enable you to divide your data in smaller groups of data. In most cases, table partitions are created on a **date column**. Partitioning is supported in all dedicated SQL pool table types. Partitioning can only be done on **one column**.

## Benefits
Partitioning can benefit data maintenance and query performance.

### Benefits to loads
In most cases data is partitioned on a date column that is closely tied to the order in which the data is loaded into the SQL pool. One of the greatest benefits of using partitions to maintain data is the avoidance of transaction logging. Instead of inserting or updating data through INSERT, UPDATE and DELETE (doing it row by row, which could take a long time), using partitioning can improve performance. Partition switching can be used to quickly remove or replace a section of a table.

For example a delete statement (*a sales fact table might contain just data for the past 36 months. At the end of every month, the oldest month of sales data is deleted from the table.*) can take too much time, as well as create the risk of **large transactions that take a long time to rollback if something goes wrong**. A more optimal approach is to drop the oldest partition of data. Where deleting the individual rows could take hours, **deleting an entire partition could take seconds**.

### Benefits to queries
A query that applies a filter to partitioned data can **limit the scan to only the qualifying partitions**. This method of filtering can avoid a full table scan and only scan a smaller subset of data.

## Partition sizing
