#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh

kinit -kt /opt/keytabs/hdfs.keytab hdfs/clients.lc.cluster@LC.CLUSTER

hadoop fs -mkdir -p /user/spark && hadoop fs -chown spark /user/spark && hadoop fs -chmod 777 /user/spark
hadoop fs -mkdir -p /user/hive && hadoop fs -chown hive /user/hive && hadoop fs -chmod 777 /user/hive
hadoop fs -mkdir -p /user/user1 && hadoop fs -chown user1 /user/user1 && hadoop fs -chmod 777 /user/user1
hadoop fs -mkdir -p /user/user2 && hadoop fs -chown user1 /user/user2 && hadoop fs -chmod 777 /user/user2