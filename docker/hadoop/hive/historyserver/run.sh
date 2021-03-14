#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh
mkdir -p $HADOOP_HOME/yarn/timeline
mv /tmp/hive_conf/* $HIVE_HOME/conf/
su - yarn -c "$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR timelineserver"