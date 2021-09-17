# Docker4Hadoop
Running a Hadoop cluster locally is a labor-intensive process, especially with Kerberos enabled. This repository allows you to quickly launch only the necessary Hadoop components in Docker: HDFS, Hive, Spark, as well as Ozone (a replacement for HDFS).

## Building Images
```shell
docker-compose -f docker-vm.yml build krb5 core hadoop-base hadoop-namenode hadoop-datanode hadoop-hive hadoop-nodemanager hadoop-resourcemanager hadoop-historyserver clients 
```
## Launch Options
### HDFS Only
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn clients
```
### HDFS & Hive
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn hive-server hive-metastore hive-metastore-db clients
```
### HDFS & Spark
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn resourcemanager nodemanager historyserver clients
```
### HDFS, Hive & Spark
```shell
docker-compose -f docker-compose.yml up -d krb5 hdfs-nn hdfs-dn hive-server hive-metastore hive-metastore-db resourcemanager nodemanager historyserver clients 
```

## Commands
### krb init
```shell
kinit -kt /opt/hadoop-2.6.5/keytabs/hdfs.keytab hdfs/clients.lc.cluster@LC.CLUSTER
```
### hive connect
```shell
beeline -u "jdbc:hive2://hive-server.lc.cluster:10000/default;principal=hive/_HOST@LC.CLUSTER"
```
### spark-shell
```
# hdfs
val fs = org.apache.hadoop.fs.FileSystem.get(new java.net.URI("hdfs://ns:8020"), sc.hadoopConfiguration)
val status = fs.listStatus(new org.apache.hadoop.fs.Path("/"))
status.foreach(x => println(x.getPath))

# hive
spark.sql("show databases").show()
```