#!/usr/bin/expect

spawn service mariadb start
expect eof

sleep 5

spawn mysql_secure_installation

expect "Enter current password for root (enter for none):"
send "\n"

expect "Switch to unix_socket authentication"
send "Y\n"

expect "Change the root password?"
send "n\n"

expect "Remove anonymous users?"
send "Y\n"

expect "Disallow root login remotely?"
send "Y\n"

expect "Remove test database and access to it?"
send "Y\n"

expect "Reload privilege tables now?"
send "Y\n"

expect eof