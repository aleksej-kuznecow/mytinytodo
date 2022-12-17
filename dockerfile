FROM php:8.2-apache
LABEL author=aleksej.kuznecow
RUN apt-get update
RUN apt-get install -y wget curl
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/html
RUN wget $(curl -s https://api.github.com/repos/maxpozdeev/mytinytodo/releases/latest | grep 'browser_' | cut -d\" -f4) -O latest.tar.gz
RUN tar -xf latest.tar.gz
RUN rm latest.tar.gz
RUN cp -R mytinytodo/* .
RUN rm -r ./mytinytodo
RUN chmod -R 777 . && chown -R www-data:www-data .
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
