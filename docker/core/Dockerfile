FROM centos:7
USER root

RUN yum install -y dos2unix less net-tools bind-utils java-1.8.0-openjdk java-1.8.0-openjdk-devel nc \
    which unzip krb5-workstation git maven wget netcat tar openssh-server python3 sshpass python3.x86_64-python-pip \
    && yum clean all \
    && rm -rf /var/cache/yum

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN ln -fs /usr/bin/python3.6 /usr/bin/python \
    && curl -k https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py \
    && python get-pip.py --trusted-host pypi.org --trusted-host files.pythonhosted.org \
    && pip3 --trusted-host pypi.org --trusted-host files.pythonhosted.org install j2cli[yaml];

COPY ./conf/jattach /usr/local/bin/jattach
RUN  chmod +x /usr/local/bin/jattach

# Install Krb5 && sshd
COPY ./conf/krb5.conf /etc/
RUN cd /etc/ssh \
    && ssh-keygen -A \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Add users
RUN echo -e "123456\n123456\n" | passwd root \
    && echo "echo '123456' | kinit" >> ~/.bashrc \
    && ssh-keygen -f "/root/.ssh/id_rsa" -q -P "" \
    && cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys \
    && chmod 600 ~/.ssh/*