FROM centos:7
USER root

RUN yum -y install dos2unix less net-tools bind-utils openssh-server openssh-clients sshpass openssl httpd\
    && yum -y install krb5-libs krb5-server krb5-workstation java-1.8.0-openjdk-headless.x86_64 \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN mkdir /tmp/krb5
COPY ./conf /tmp/krb5/
RUN chmod +x /tmp/krb5/init.sh && dos2unix /tmp/krb5/init.sh

RUN cd /etc/ssh \
    && ssh-keygen -A \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

WORKDIR /tmp/krb5
CMD [ "/tmp/krb5/init.sh" ]