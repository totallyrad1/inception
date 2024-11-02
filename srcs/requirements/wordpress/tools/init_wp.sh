#!/usr/bin/expect

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

spawn wp config create --dbname=$env(MARIADB_DBNAME) --dbuser=$env(MARIADB_USER) --dbpass=$env(MARIADB_PASS) --dbhost=mariadb --allow-root
expect eof

spawn wp core install --url=localhost --title=WP-CLI --admin_user=$env(WP_ADMIN) --admin_password=$env(WP_ADMINGPASS) --admin_email=$env(WP_MAIL) --allow-root
expect eof

spawn service php8.2-fpm stop
expect eof

spawn sed -ie "s/127.0.0.1/0.0.0.0/g" /etc/php/8.2/fpm/pool.d/www.conf
expect eof

spawn sed -ie "s/9001/9000/g" /etc/php/8.2/fpm/pool.d/www.conf
expect eof

exec php-fpm8.2 -F