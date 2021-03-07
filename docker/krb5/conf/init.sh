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

mkdir /opt/keytabs

kadmin -w 123456 -q "addprinc -randkey om"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/om.keytab om@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey scm"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/scm.keytab scm@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey dn"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/dn.keytab dn@LC.CLUSTER"
kadmin -w 123456 -q "addprinc -randkey recon"
kadmin -w 123456 -q "ktadd -k /opt/keytabs/recon.keytab recon@LC.CLUSTER"

/usr/sbin/sshd
echo -e "123456\n123456\n" | passwd root
/usr/sbin/sshd
sleep 5
echo "Log"  > /tmp/logfile.log
tail -f /tmp/logfile.log




