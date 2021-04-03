FROM hadoop-base:2.6

ENV USER=root
ENV HIVE_VERSION=2.3.2
ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH

WORKDIR /opt

RUN wget --no-check-certificate https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	wget --no-check-certificate https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
    rm $HIVE_HOME/lib/guava*.jar && \
    cp /tmp/hadoop-$HADOOP_VERSION/share/hadoop/common/lib/guava*.jar $HIVE_HOME/lib/ ;


RUN mkdir -p /tmp/hive_conf
COPY ./conf/* /tmp/hive_conf/

COPY ./run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["entrypoint.sh"]
