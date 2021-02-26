#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh

mkdir -p $HADOOP_DATA_DIR/name && mkdir -p $HADOOP_DATA_DIR/data
mv /tmp/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml

echo "12345678" | $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR datanode