There are 4 table types in KDB, each with their own best use cases.

| serialization      | representation                                                     | best where                                                  |
| ------------------ | ------------------------------------------------------------------ | ----------------------------------------------------------- |
| object             | single binary file                                                 | small and most queries use most columns                     |
| splayed table      | directory of column files                                          | up to 100 million rows                                      |
| partitioned table  | table partitioned by e.g. date, with a splayed table for each date | more than 100 million records; or growing steadily          |
| segmented database | partitioned tables distributed across disks                        | tables larger than disks; or you need to parallelize access |
### Flat Files
```
`:filename set table;
save table;
```
Starting with the simplest, a [[#Flat Files]] is an object that gets serialized as a binary file and written to disk. This is normally a table but can be pretty much anything. Another example would be a list of atoms, which we see use as a enumerated sym file in the more complex databases types.
Ideally this type is kept to use cases where the tables are small and all of the columns are regularly used.

### Splayed Tables
`:dirname/ set table
In the case where the table is growing too big or not all columns are used in the queries we should consider switching to a [[#Splayed Tables]], which is a table that has each of it's columns stored as a single file under a directory with the tables name. 
The table must be
- fully enumerated; i.e. no repeated symbols
- simple, not keyed
The tables columns are referenced in a file called ".d" and this helps facilitate column addition and removal by simply adding or removing columns from the ".d" file. 
Why does this help? It reduces the amount of data that needs to be deserialized into memory when a query does not contain all the columns of the table as the unused tables are simply ignored.
The sweet spot for [[#Splayed Tables]] is around 100 million records but anymore than that, or if memory becomes an issue with some of the columns, then we will want to use [[Databases#Partitioned |PARTITIONED TABLES]] instead.

### Partitioned Tables
```
`:/db/2015.01.01/t/ set ([] ti:09:30:00 09:31:00; p:101 102f)
```
Are similar to [[#Splayed Tables]] but with additional decomposition of it's structure by having another layer added to it's directory hierarchy. This is typically derived from a date field and would lead to a structure like tableName -> partitionN -> columns, but any integral type column will do
Why does this help? It further reduces the amount of data that needs to be deserialized into memory by allowing only specified dates and columns to be loaded into memory instead of the entire table or all of a column.
This table structure also has an interesting optimization technique in the form of parallel processing, as any query ran against it will check the date partition and columns in sequence, but, if q is started with more than 1 slave, it can check multiple slices simultaneously which will drastically increase speed depending on the number of additional cores specified in the process. (using -s  cmdline or \s in process)

### Segmented Tables
The final storage type is [[#Segmented Tables]]. Segmentation is an additional level of structure on top of partitioning. Segmentation spreads a partitioned table’s records across multiple directories that have the same structure as the root directory in a partitioned database.  Each segment is a pseudo-root that contains a collection of partition directories.
The root directory now only has two files:
1)  par.txt which contains the path to all the segments
2) sym file
Segments are usually stored on other volumes to maximize parallelization via different I/O channel.
Segments can be anything as long as they are complete, eg cover the range of data.
Examples of segmenting logic:
1) every odd numbered day  goes into segment1, every even day goes into segmenent2
2) every trade symbol from a-m goes into segment1, every trade symbol from n-z goes into segment2
3) By exchange, NYSE NASDQ

[[#Segmented Tables]] really shine when you are trying to optimize huge tables by raking advantage of different I/O channels and parallel/concurrent processing.
example:
If our storage device had 4 i/o channels we would want 4 segments and q to start with 4 slaves.