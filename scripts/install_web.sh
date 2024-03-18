#!/bin/bash

## Install DAMN VULNERABLE WEB APPLICATION (DVWA)

IP=$(hostname -I | awk '{print $2}')

echo "START - Web Server configuration - "$IP

echo "=> [1]: Installing required packages..."
  DEBIAN_FRONTEND=noninteractive
  apt-get update  -o Dpkg::Progress-Fancy="0" -q -y >> /tmp/install_web.log 2>&1
  apt-get -y -q -o Dpkg::Progress-Fancy="0" install \
    apache2 \
    mariadb-server \
    php php-mysqli \
    php-gd \
    libapache2-mod-php \
    unzip \
      >> /tmp/install_web.log 2>&1

echo "=> [2]: DVWA Installation"
  wget -q https://github.com/digininja/DVWA/archive/master.zip \
    >> /tmp/install_web.log 2>&1
  unzip master.zip -d /var/www/html/ \
    >> /tmp/install_web.log 2>&1
  mv /var/www/html/DVWA-master/ /var/www/html/dvwa/
  rm master.zip

echo "=> [3]: Database Configuration"
  mysql -e "CREATE DATABASE dvwa"
  mysql -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd'"

echo "=> [4]: FileSystem Configuration"
  chown www-data /var/www/html/dvwa/hackable/uploads/
#  chown www-data /var/www/html/dvwa/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
  chown www-data /var/www/html/dvwa/config
  sed -e "s|\[ 'default_security_level' \] = 'impossible';|\[ 'default_security_level' \] = 'low';|" \
    /var/www/html/dvwa/config/config.inc.php.dist > /var/www/html/dvwa/config/config.inc.php
  sed -i "s/allow_url_include = Off/allow_url_include = On/g" /etc/php/7.4/apache2/php.ini
  sed -i "s/display_errors = Off/display_errors = On/g" /etc/php/7.4/apache2/php.ini
  sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" /etc/php/7.4/apache2/php.ini

echo "=> [5]: Restart services"
  service apache2 stop
  service apache2 start
