#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh

mkdir -p $HADOOP_DATA_DIR/name && mkdir -p $HADOOP_DATA_DIR/edits && mkdir -p $HADOOP_DATA_DIR/data

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format SC
echo "12345678" | $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode