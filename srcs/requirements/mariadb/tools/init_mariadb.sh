#!/usr/bin/expect

spawn sed -ie "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf
expect eof

exec service mariadb start

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

spawn mysql -u root -p

expect "Enter password for user root:"
send "\n"  

expect "MariaDB"
send "CREATE DATABASE $env(MARIADB_DBNAME);\n"

expect "MariaDB"
send "CREATE USER '$env(MARIADB_USER)'@'%' IDENTIFIED BY '$env(MARIADB_PASS)';\n"

expect "MariaDB"
send "GRANT ALL PRIVILEGES ON $env(MARIADB_DBNAME).* TO '$env(MARIADB_USER)'@'%';\n"

expect "MariaDB"
send "FLUSH PRIVILEGES;\n"

expect "MariaDB"
send "quit\n"

expect eof

exec service mariadb stop

exec mariadbd-safe