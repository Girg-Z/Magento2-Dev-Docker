FROM ubuntu:20.04

EXPOSE 80
EXPOSE 443

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt upgrade -y && \
    # Install apache2
    apt install apache2 -y && \
    apt install git -y

#Ensite magento2 conf, enable mod rewrite
RUN apt install wget -y && \
    wget https://raw.githubusercontent.com/Girg-Z/Magento2-Dev-Docker/main/lib/magento2.conf -P /etc/apache2/sites-available &&\
    a2dissite 000-default.conf &&\
    rm /etc/apache2/sites-available/000-default.conf &&\
    a2ensite magento2.conf && \
    a2enmod rewrite

#Install php 7.3
RUN apt install software-properties-common -y && \
    add-apt-repository ppa:ondrej/php -y && \
    apt update && \
    apt install php7.3 libapache2-mod-php7.3 php7.3-common php7.3-gmp php7.3-curl php7.3-soap php7.3-bcmath php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-mysql php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y && \
    #Modify php.ini for magento
    sed -i "s/memory_limit = .*/memory_limit = 3072M/" /etc/php/7.3/apache2/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.3/apache2/php.ini && \
    sed -i "s/zlib.output_compression = .*/zlib.output_compression = on/" /etc/php/7.3/apache2/php.ini && \
    sed -i "s/max_execution_time = .*/max_execution_time = 18000/" /etc/php/7.3/apache2/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/apache2/php.ini && \
    sed -i "s/;opcache.save_comments.*/opcache.save_comments = 1/" /etc/php/7.3/apache2/php.ini && \
    # remove apt cache from image
    apt clean all

CMD ["apachectl", "-D", "FOREGROUND"]