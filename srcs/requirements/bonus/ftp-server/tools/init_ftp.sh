#!/usr/bin/expect

spawn sed -ie "s|anonymous_enable=NO|anonymous_enable=YES|g" /etc/vsftpd.conf
expect eof

spawn service vsftpd start
expect eof

spawn  service vsftpd status
expect eof

spawn useradd -m $env(FTP_USER)
expect eof

spawn passwd $env(FTP_USER)

expect "New password:"
send "$env(FTP_PASSWD)\n"

expect "Retype new password:"
send "$env(FTP_PASSWD)\n"

expect eof

spawn service vsftpd stop
expect eof

exec vsftpd /etc/vsftpd.conf