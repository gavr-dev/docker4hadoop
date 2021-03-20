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

kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/yarn.keytab HTTP/$HOST@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey yarn/$HOST"
kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/yarn.keytab yarn/$HOST@LC.CLUSTER"
adduser yarn
echo -e "123456\n123456\n" | passwd yarn
chown yarn:yarn $HADOOP_HOME/keytabs/yarn.keytab

kadmin -w 123456 -q "addprinc -randkey hive/$HOST"
kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/hive.keytab hive/$HOST@LC.CLUSTER"
adduser hive
echo -e "123456\n123456\n" | passwd hive
chown hive:hive $HADOOP_HOME/keytabs/hive.keytab

kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/spark.keytab HTTP/$HOST@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey spark/$HOST"
kadmin -w 123456 -q "ktadd -k $HADOOP_HOME/keytabs/spark.keytab spark/$HOST@LC.CLUSTER"
adduser spark
echo -e "123456\n123456\n" | passwd spark
chown spark:spark $HADOOP_HOME/keytabs/spark.keytab

sshpass -p '123456' scp -o StrictHostKeyChecking=no root@krb5.lc.cluster:/opt/*.keytab /opt/hadoop-2.6.5/keytabs/


keytool -genkey -noprompt -dname "CN=$HOSTNAME, OU=AA, O=AA, L=AA, S=AA, C=AA" -alias "$HOSTNAME" -keystore "keystore.jks" -storepass "12345678" -keypass "12345678"
cp $HADOOP_HOME/keytabs/hdfs.keytab /root/hadoop.keytab
cp keystore.jks /root/.keystore
echo "12345678" > /root/hadoop-http-auth-signature-secret
chmod -R 777 /root


cp $HADOOP_CONF_DIR/yarn-site.xml.template_yarn $HADOOP_CONF_DIR/yarn-site.xml;
cp $HADOOP_CONF_DIR/mapred-site.xml.template_yarn $HADOOP_CONF_DIR/mapred-site.xml
