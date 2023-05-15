FROM ubuntu:22.04

MAINTAINER Sergey Zinchenko <sergo.noob007@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y nginx php-fpm && rm -rf /var/lib/apt/lists/* && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo '<?php echo "Hello World"; ?>' > /var/www/html/index.php && \
    sed -i 's/index index.html index.htm index.nginx-debian.html/index index.php index.html index.htm index.nginx-debian.html/g' /etc/nginx/sites-available/default && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.1/fpm/php.ini && \
    echo "date.timezone='UTC'" >> /etc/php/8.1/fpm/php.ini

CMD ["php-fpm", "nginx"]

EXPOSE 80
