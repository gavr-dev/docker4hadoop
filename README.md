## Building Images
```shell
docker-compose -f docker-vm.yml build krb5 core hadoop-base hadoop-namenode hadoop-datanode hadoop-hive hadoop-nodemanager hadoop-resourcemanager hadoop-historyserver 
```
## Launch Options
### HDFS Only
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn
```
### HDFS & Hive
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn hive-server hive-metastore hive-metastore-db
```
### HDFS & Spark
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn resourcemanager nodemanager historyserver
```
### HDFS, Hive & Spark
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn hive-server hive-metastore hive-metastore-db resourcemanager nodemanager historyserver
```