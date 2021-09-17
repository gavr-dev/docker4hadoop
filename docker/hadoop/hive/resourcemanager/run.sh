#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh
su hdfs -c "kinit -k -t /opt/keytabs/hdfs.keytab hdfs/resourcemanager.lc.cluster@LC.CLUSTER"
su hdfs -c "hadoop fs -chmod -R 777 /"
mv /tmp/hive_conf/* $HIVE_HOME/conf/
su - yarn -c "$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR resourcemanager"