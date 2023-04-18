FROM quay.io/centos/centos:7

LABEL maintainer="Stephen Cuppett <steve@cuppett.com>"

COPY plesk.repo /etc/yum.repos.d/plesk.repo
COPY epel.repo /etc/yum.repos.d/epel.repo

# install the support we need
RUN set -ex; \
        \
        yum -y update; \
        yum -y install \
        plesk-php80 plesk-php80-xml plesk-php80-pdo plesk-php80-cli plesk-php80-soap plesk-php80-intl plesk-php80-gd plesk-php80-mbstring \
        plesk-php81 plesk-php81-xml plesk-php81-pdo plesk-php81-cli plesk-php81-soap plesk-php81-intl plesk-php81-gd plesk-php81-mbstring \
        plesk-php82 plesk-php82-xml plesk-php82-pdo plesk-php82-cli plesk-php82-soap plesk-php82-intl plesk-php82-gd plesk-php82-mbstring \
        rsync gettext unzip wget openssh-clients git awscli; \
        yum clean all;

# install composer
RUN set -ex; \
        \
        export PATH=/opt/plesk/php/8.1/bin:$PATH; \
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
        php composer-setup.php --install-dir=bin --filename=composer; \
        rm composer-setup.php; composer --version;

# install phpunit
RUN set -ex; \
       \
       export PATH=/opt/plesk/php/8.1/bin:$PATH; \
       wget -O /bin/phpunit https://phar.phpunit.de/phpunit-10.0.10.phar; \
       chmod +x /bin/phpunit; \
       phpunit --version;

