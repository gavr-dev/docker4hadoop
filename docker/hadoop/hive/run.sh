#!/bin/bash

launch_hiveserver2() {
	su hdfs -c "kinit -k -t /opt/keytabs/hdfs.keytab hdfs/hive-server.lc.cluster@LC.CLUSTER"
	su hdfs -c "hadoop fs -mkdir -p    /tmp/hadoop-yarn/staging"
	su hdfs -c "hadoop fs -mkdir -p    /user/hive/warehouse"
	su hdfs -c "hadoop fs -chown hive:hive /user/hive/warehouse"
	su hdfs -c "hadoop fs -chown hive:hive /tmp"
	su hdfs -c "hadoop fs -chmod 777 /tmp/hadoop-yarn/staging"
	$HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.thrift.port=10000 --hiveconf hive.root.logger=INFO,console
}

launch_metastore(){
	$HIVE_HOME/bin/hive --service metastore
}

/usr/local/bin/init.sh

tar -xzvf /tmp/apache-hive-2.3.2-bin.tar.gz
mv apache-hive-2.3.2-bin /opt/hive
mv /tmp/hive_conf/* $HIVE_HOME/conf/

if [ "$1" = 'hiveserver2' ]; then
	launch_hiveserver2
elif [ "$1" = 'hivemetastore' ]; then
	launch_metastore
else
	echo "Wrong component"
fi
