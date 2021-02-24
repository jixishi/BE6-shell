#!/bin/bash
frommail='be6-cloud@qq.com'
smtp_host='smtp.qq.com'
smtp_auth_user='be6-cloud@qq.com'
smpt_auth_password=''
certs_dir=/root/.certs
mail_conf=/etc/mail.rc

echo "set from=$frommail" >> /etc/mail.rc
echo "set smtp=$smtp_host" >> /etc/mail.rc
echo "set smtp-auth-user=$smtp_auth_user" >> /etc/mail.rc
echo "set smtp-auth-password=$smpt_auth_password" >> /etc/mail.rc
echo "set smtp-auth=login" >> /etc/mail.rc
echo "set smtp-use-starttls" >> /etc/mail.rc
echo "set ssl-verify=ignore" >> /etc/mail.rc
echo "set nss-config-dir=$certs_dir" >> /etc/mail.rc


[ ! -d $certs_dir ] && mkdir -p $certs_dir
echo -n | openssl s_client -connect $smtp_host:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >$certs_dir/qq.crt
certutil -A -n "GeoTrust SSL CA" -t "C,," -d $certs_dir -i $certs_dir/qq.crt
certutil -A -n "GeoTrust Global CA" -t "C,," -d $certs_dir -i $certs_dir/qq.crt
certutil -L -d $certs_dir

echo -e "欢迎使用\033[36mBE6\033[0m自动检测脚本"
echo -e "QQ群\033[36m780806682\033[0m"
read -p "请输入接收邮箱: " email
read -p "请输入检测服务器名称" name
read -p "请输入端口号" port
echo "" | mail -s "$name-$port" $email

