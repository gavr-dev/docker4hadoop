#!/bin/bash

HOST=$(cat /etc/hostname)

cp -r /tmp/hadoop-$HADOOP_VERSION $HADOOP_HOME
mkdir -p $HADOOP_HOME/logs
mkdir -p $HADOOP_DATA_DIR
mkdir $HADOOP_HOME/keytabs
ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop
cp /tmp/conf/* $HADOOP_CONF_DIR/

kadmin -w 123456 -q "addprinc -randkey HTTP/$HOST"
kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/hdfs.keytab HTTP/$HOST@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey hdfs/$HOST"
kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/hdfs.keytab hdfs/$HOST@LC.CLUSTER"
adduser hdfs
echo -e "123456\n123456\n" | passwd hdfs
chown hdfs:hdfs $HADOOP_HOME/keytabs/hdfs.keytab

sshpass -p '123456' scp -o StrictHostKeyChecking=no root@krb5.lc.cluster:/opt/*.keytab /opt/hadoop-2.6.5/keytabs/
