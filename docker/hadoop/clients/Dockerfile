FROM hadoop-base:2.6

# Install Hive CLI
WORKDIR /opt
RUN wget --no-check-certificate https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
    rm -rf apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_HOME=/opt/hive
ENV PATH $HIVE_HOME/bin/:$PATH

RUN mkdir -p /etc/hive/conf
COPY ./hive/conf/*-site.xml /etc/hive/conf/
COPY ./base/conf/*-site.xml /etc/hive/conf/

# Install Spark-shell
RUN wget --no-check-certificate https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
	tar -xzvf spark-$SPARK_VERSION-bin-hadoop2.7.tgz && \
	mv spark-$SPARK_VERSION-bin-hadoop2.7 spark && \
    rm -rf spark-$SPARK_VERSION-bin-hadoop2.7.tgz
ENV SPARK_HOME=/opt/spark
ENV PATH $SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

RUN mkdir -p /etc/spark/conf
COPY ./base/conf/*-site.xml /etc/spark/conf/
COPY ./spark/conf/* /etc/spark/conf/
COPY ./hive/conf/*-site.xml /etc/spark/conf/

ENV SPARK_CONF_DIR=/etc/spark/conf
ENV HADOOP_CONF_DIR=/etc/spark/conf
ENV YARN_CONF_DIR=/etc/spark/conf

# Custom scripts
RUN mkdir -p /opt/scripts

RUN dos2unix /etc/spark/conf/* && dos2unix /etc/hive/conf/*
ADD ./clients/run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh