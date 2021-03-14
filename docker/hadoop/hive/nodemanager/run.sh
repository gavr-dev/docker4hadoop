#!/bin/bash

/usr/sbin/sshd
/usr/local/bin/init.sh

# yarn mapred
mkdir -p /tmp/hadoop-yarn/nm-local-dir/usercache/yarn/
mkdir -p /tmp/hadoop-yarn/container-logs
chown yarn:yarn /tmp/hadoop-yarn/nm-local-dir
chown yarn:yarn /tmp/hadoop-yarn/container-logs
chown yarn:yarn /tmp/hadoop-yarn/nm-local-dir/usercache/yarn/
chown -R yarn:yarn /opt/hadoop-2.6.5/logs

# container executor
chown root:yarn /opt/hadoop-2.6.5/etc/hadoop/container-executor.cfg
chown root:yarn /opt/hadoop-2.6.5/etc/hadoop
chown root:yarn /opt/hadoop-2.6.5/etc
chown root:yarn /opt/hadoop-2.6.5
chown root:yarn /opt
chmod -R 555 /opt/hadoop-2.6.5
chown root:yarn /opt/hadoop-2.6.5/bin/container-executor
chmod 6050 /opt/hadoop-2.6.5/etc/hadoop/container-executor.cfg
chmod 6050 /opt/hadoop-2.6.5/bin/container-executor

mv /tmp/hive_conf/* $HIVE_HOME/conf/

su - yarn -c "$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR nodemanager"