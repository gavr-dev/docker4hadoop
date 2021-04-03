FROM hadoop-base:2.6

ENV HIVE_VERSION=2.3.2

# Install Hive CLI
WORKDIR /opt
RUN wget --no-check-certificate https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
    rm -rf apache-hive-$HIVE_VERSION-bin.tar.gz

ENV HIVE_HOME=/opt/hive
ENV PATH $HIVE_HOME/bin/:$PATH

# Custom scripts
RUN mkdir -p /opt/scripts

ADD ./run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh