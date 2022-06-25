<h1 align="center">Docker4Hadoop</h1>
<p align="center">
<img src="https://img.shields.io/github/last-commit/gavr-dev/docker4hadoop"/>
<a href="https://github.com/gavr-dev/docker4hadoop/tags" alt="Tag"><img src="https://img.shields.io/github/v/tag/gavr-dev/docker4hadoop"/></a>
<a href="https://github.com/gavr-dev/docker4hadoop/blob/main/LICENSE" alt="GPLv3 licensed"><img src="https://img.shields.io/badge/license-GPLv3-blue"/></a>
</p>

Running a **Hadoop** cluster locally is a labor-intensive process, especially with **Kerberos** enabled. <br/> 
This repository allows you to quickly launch only the necessary **Hadoop** components (HDFS, Hive, YARN, Spark) in Docker with full Kerberos support.<br/>
All components can be run independently of each other!

## Containers
- **krb5** - Kerberos server
- **hdfs-nn** - HDFS Namenode
- **hdfs-db** - HDFS Datanode
- **hive-server** - Hive Server
- **hive-metastore** - Hive Metastore
- **hive-metastore-db** - Hive DB
- **nodemanager** - YARN Node Manager
- **resourcemanager** - YARN Resource Manager
- **historyserver** - YARN History Server
- **clients** - Hadoop CLI, Hive Client, Spark client

## Build
To build all the images, just call **build** for **docker-vm.yml**.
```shell
docker-compose -f docker-vm.yml build 
```
## Kerberos
All system and user keytabs are located in the ```/opt/keytabs``` directory

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

## Useful commands
### krb init
```shell
kinit -kt /opt/hadoop/keytabs/hdfs.keytab hdfs/clients.lc.cluster@LC.CLUSTER
```
### beeline
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