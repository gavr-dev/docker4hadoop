FROM hadoop-base:2.6
ENV HADOOP_VERSION 2.6.5
ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION

ADD ./run.sh /usr/local/bin/run.sh
ADD ./conf/hdfs-site.xml /tmp/hdfs-site.xml
RUN chmod a+x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh
#CMD ["/run.sh"]