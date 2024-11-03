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

sleep 30

spawn wp config create --dbname=$env(MARIADB_DBNAME) --dbuser=$env(MARIADB_USER) --dbpass=$env(MARIADB_PASS) --dbhost=mariadb --allow-root
expect eof

sleep 5

spawn wp core install --url=localhost --title=WP-CLI --admin_user=$env(WP_ADMIN) --admin_password=$env(WP_ADMINPASS) --admin_email=$env(WP_MAIL) --allow-root
expect eof

spawn wp user create $env(WP_USER) $env(WP_USERMAIL) --user_pass=$env(WP_USERPASS) --role=contributor --allow-root
expect eof

exec chmod -R 777 wp-content

# exec echo -e "define('WP_REDIS_HOST', 'redis');\ndefine('WP_REDIS_PORT', 6379);\ndefine('WP_REDIS_PASSWORD', '$env(REDIS_PASS)');\ndefine( 'WP_REDIS_DATABASE', 0 );\n" >> wp-config.php
spawn wp config set WP_REDIS_HOST redis --allow-root
expect eof

spawn wp config set WP_REDIS_PORT 6379 --allow-root
expect eof

spawn wp config set WP_CACHE 'true' --allow-root
expect eof

spawn wp config set WP_REDIS_DATABASE 0 --allow-root
expect eof

spawn wp plugin install redis-cache --activate --allow-root
expect eof

spawn wp redis enable --allow-root
expect eof

spawn service php8.2-fpm stop
expect eof


exec php-fpm8.2 -F