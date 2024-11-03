#!/usr/bin/expect

spawn sed -ie "s/127.0.0.1/0.0.0.0/g" /etc/php/8.2/fpm/pool.d/www.conf
expect eof

spawn sed -ie "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf
expect eof

spawn sed -ie "s/9001/9000/g" /etc/php/8.2/fpm/pool.d/www.conf
expect eof

spawn curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
expect eof


spawn php wp-cli.phar --info
expect eof


spawn chmod +x wp-cli.phar
expect eof


spawn mv wp-cli.phar /usr/local/bin/wp
expect eof

spawn wp --info
expect eof

spawn wp core download --path=/var/www/inception --allow-root
expect eof

sleep 5

spawn wp config create --dbname=$env(MARIADB_DBNAME) --dbuser=$env(MARIADB_USER) --dbpass=$env(MARIADB_PASS) --dbhost=mariadb --allow-root
expect eof

sleep 5

spawn wp user create $env(WP_USER) $env(WP_USERMAIL) --user_pass=$env(WP_USERPASS) --role=author --allow-root
expect eof

sleep 5

spawn wp core install --url=localhost --title=WP-CLI --admin_user=$env(WP_ADMIN) --admin_password=$env(WP_ADMINPASS) --admin_email=$env(WP_MAIL) --allow-root
expect eof

spawn service php8.2-fpm stop
expect eof


exec php-fpm8.2 -F