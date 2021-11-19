FROM registry.access.redhat.com/ubi7

LABEL maintainer="Stephen Cuppett <steve@cuppett.com>"

COPY plesk.repo /etc/yum.repos.d/plesk.repo

# install the support we need
RUN set -ex; \
        \
        yum -y update; \
        yum -y install \
        plesk-php74 plesk-php74-xml plesk-php74-pdo plesk-php74-cli plesk-php74-soap plesk-php74-intl plesk-php74-gd plesk-php74-mbstring \
        plesk-php80 plesk-php80-xml plesk-php80-pdo plesk-php80-cli plesk-php80-soap plesk-php80-intl plesk-php80-gd plesk-php80-mbstring \
        rsync tar gettext unzip wget openssh-clients git awscli; \
	    yum clean all;

# install composer
RUN set -ex; \
        \
        export PATH=/opt/plesk/php/7.4/bin:$PATH; \
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
        php composer-setup.php --install-dir=bin --filename=composer; \
        rm composer-setup.php; composer --version;

# install phpunit
RUN set -ex; \
       \
       export PATH=/opt/plesk/php/7.4/bin:$PATH; \
       wget -O /bin/phpunit https://phar.phpunit.de/phpunit-9.1.4.phar; \
       chmod +x /bin/phpunit; \
       phpunit --version;

