FROM core:0.1
ENV USER=root

ENV HADOOP_VERSION 2.6.5
ENV HIVE_VERSION=2.3.2
ENV SPARK_VERSION=2.4.7

ENV HADOOP_URL https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HADOOP_DATA_DIR=$HADOOP_HOME/data
ENV YARN_HOME=$HADOOP_HOME
ENV PATH $HADOOP_HOME/bin/:$PATH

ENV MULTIHOMED_NETWORK=1
ENV HADOOP_ROOT_LOGGER=INFO,console

RUN echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | tee -a /etc/profile && source /etc/profile && echo $JAVA_HOME
ENV JAVA_HOME=/etc/alternatives/jre/

RUN set -x \
    && curl -fkSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fkSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /tmp/ \
    && rm /tmp/hadoop.tar.gz*

RUN  mkdir -p /tmp/conf
COPY ./conf/* /tmp/conf/
RUN dos2unix /tmp/conf/*

COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && dos2unix /usr/local/bin/entrypoint.sh
COPY ./init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh && dos2unix /usr/local/bin/init.sh
ENTRYPOINT ["entrypoint.sh"]