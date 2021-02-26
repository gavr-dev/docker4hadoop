FROM hadoop-base:2.6

#RUN mkdir -p $HADOOP_DATA_DIR/name && mkdir -p $HADOOP_DATA_DIR/edits && mkdir -p $HADOOP_DATA_DIR/data

# Install Hadoop CLI
RUN mkdir /opt/hadoop-cli
COPY ./cli /opt/hadoop-cli/
RUN find /opt/hadoop-cli/bin -type f -print0 | xargs -0 dos2unix \
    && find /opt/hadoop-cli/etc -type f -print0 | xargs -0 dos2unix \
    && find /opt/hadoop-cli/libexec -type f -print0 | xargs -0 dos2unix \
    && find /opt/hadoop-cli/sbin -type f -print0 | xargs -0 dos2unix \
    && chmod -R 755 /opt/hadoop-cli

RUN echo "export HADOOP_CLI_HOME=/opt/hadoop-cli" >> ~/.bashrc \
    && echo "export PATH=\$PATH:\$HADOOP_CLI_HOME/sbin:\$HADOOP_CLI_HOME/bin" >> ~/.bashrc

RUN mkdir -p /opt/scripts

ADD ./run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh && dos2unix /usr/local/bin/run.sh
#CMD ["/run.sh"]