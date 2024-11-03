#!/usr/bin/expect

spawn openssl genrsa -out server.key 2048
expect eof

spawn openssl req -new -key server.key -out server.csr

expect "Country Name"
send "MA\n"

expect "State or Province Name"
send "Béni Mellal-Khénifra\n"

expect "Locality Name"
send "khouribga\n"

expect "Organization Name"
send "1337 coding school\n"

expect "Organizational Unit Name"
send "1337\n"

expect "Common Name"
send "$env(DOMAINNAME)\n"

expect "Email Address"
send "asnaji@student.1337.ma\n"

expect "A challenge password"
send "msawebb haka\n"

expect "An optional company name"
send "totally rad\n"

expect eof

spawn openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
expect eof

spawn mv /src/server.key /etc/ssl/private/
expect eof

spawn mv /src/server.crt /etc/ssl/certs/
expect eof

spawn sed -ie "s|CERTKEY|$env(CERTKEY)|g" /etc/nginx/nginx.conf
expect eof

spawn sed -ie "s|CERT|$env(CERT)|g" /etc/nginx/nginx.conf
expect eof

spawn sed -ie "s|DOMAINNAME|$env(DOMAINNAME)|g" /etc/nginx/nginx.conf
expect eof

exec nginx -g "daemon off;"