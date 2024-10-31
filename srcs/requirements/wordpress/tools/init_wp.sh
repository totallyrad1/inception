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

spawn wp config create --dbname=my_db --dbuser=asnaji --dbpass=password --dbhost=mariadb --allow-root
expect eof

spawn wp core install --url=localhost --title="WP-CLI" --admin_user=asnajiad --admin_password=testtest1 --admin_email=info@wp-cli.org --allow-root
expect eof

spawn service php8.2-fpm stop
expect eof

exec php-fpm8.2 -F