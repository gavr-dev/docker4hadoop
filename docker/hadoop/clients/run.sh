#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh

kinit -kt /opt/hadoop/keytabs/hdfs.keytab hdfs/clients.lc.cluster@LC.CLUSTER
hadoop fs -mkdir /user/spark
hadoop fs -chown spark /user/spark
hadoop fs -mkdir /user/hive
hadoop fs -chown hive /user/hive