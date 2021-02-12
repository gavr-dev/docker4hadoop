#!/bin/bash

cp /tmp/krb5/krb5.conf /etc/krb5.conf
cp /tmp/krb5/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /tmp/krb5/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

kdb5_util create -s -P masterkey

kadmin.local -q "addprinc -pw 123456 root/admin@LC.CLUSTER"
kadmin.local -q "addprinc -pw 123456 root@LC.CLUSTER"

/usr/sbin/krb5kdc
/usr/sbin/kadmind
/usr/sbin/httpd

/usr/sbin/sshd
echo -e "123456\n123456\n" | passwd root
/usr/sbin/sshd
sleep 5
echo "Log"  > /tmp/logfile.log
tail -f /tmp/logfile.log




