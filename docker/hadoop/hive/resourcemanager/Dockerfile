FROM hadoop-base:2.6

RUN mkdir -p /opt/hive/conf
ENV HIVE_HOME /opt/hive
RUN mkdir -p /tmp/hive_conf
COPY ./conf/* /tmp/hive_conf/

ADD ./resourcemanager/run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh
# CMD ["/run.sh"]