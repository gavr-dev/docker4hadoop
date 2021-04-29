FROM hadoop-base:2.6

ADD ./run.sh /usr/local/bin/run.sh
ADD ./conf/hdfs-site.xml /tmp/hdfs-site.xml
RUN chmod a+x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh