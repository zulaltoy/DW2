### DEEL 1: instructies voor het BUILDen van de IMAGE

FROM ubuntu:20.04


RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    && rm -rf /var/lib/apt/lists/*


RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf


COPY html /var/www/html/


WORKDIR /var/www/html/


EXPOSE 80


CMD ["apache2ctl", "-D", "FOREGROUND"]
