#!/bin/bash

HOST=$(cat /etc/hostname)

cp -r /tmp/hadoop-$HADOOP_VERSION $HADOOP_HOME
mkdir -p $HADOOP_HOME/logs
mkdir -p $HADOOP_DATA_DIR
mkdir /opt/keytabs
ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop
cp /tmp/conf/* $HADOOP_CONF_DIR/

kadmin -w 123456 -q "addprinc -randkey HTTP/$HOST"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/hdfs.keytab HTTP/$HOST@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey hdfs/$HOST"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/hdfs.keytab hdfs/$HOST@LC.CLUSTER"
adduser hdfs
echo -e "123456\n123456\n" | passwd hdfs
chown hdfs:hdfs /opt/keytabs/hdfs.keytab

kadmin -w 123456 -q "ktadd -k /opt/keytabs/yarn.keytab HTTP/$HOST@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey yarn/$HOST"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/yarn.keytab yarn/$HOST@LC.CLUSTER"
adduser yarn
echo -e "123456\n123456\n" | passwd yarn
chown yarn:yarn /opt/keytabs/yarn.keytab

kadmin -w 123456 -q "addprinc -randkey hive/$HOST"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/hive.keytab hive/$HOST@LC.CLUSTER"
adduser hive
echo -e "123456\n123456\n" | passwd hive
chown hive:hive /opt/keytabs/hive.keytab

kadmin -w 123456 -q "ktadd -k /opt/keytabs/spark.keytab HTTP/$HOST@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey spark/$HOST"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/spark.keytab spark/$HOST@LC.CLUSTER"
adduser spark
echo -e "123456\n123456\n" | passwd spark
chown spark:spark /opt/keytabs/spark.keytab

sshpass -p '123456' scp -o StrictHostKeyChecking=no root@krb5.lc.cluster:/opt/keytabs/*.keytab /opt/keytabs/

adduser user1
echo -e "123456\n123456\n" | passwd user1
chown user1:user1 /opt/keytabs/user1.keytab

adduser user2
echo -e "123456\n123456\n" | passwd user2
chown user2:user2 /opt/keytabs/user2.keytab

keytool -genkey -noprompt -dname "CN=$HOSTNAME, OU=AA, O=AA, L=AA, S=AA, C=AA" -alias "$HOSTNAME" -keystore "keystore.jks" -storepass "12345678" -keypass "12345678"
cp /opt/keytabs/hdfs.keytab /root/hadoop.keytab
cp keystore.jks /root/.keystore
echo "12345678" > /root/hadoop-http-auth-signature-secret
chmod -R 777 /root


cp $HADOOP_CONF_DIR/yarn-site.xml.template_yarn $HADOOP_CONF_DIR/yarn-site.xml;
cp $HADOOP_CONF_DIR/mapred-site.xml.template_yarn $HADOOP_CONF_DIR/mapred-site.xml
