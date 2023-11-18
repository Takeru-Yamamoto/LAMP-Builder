#!/usr/bin/env bash

# #############################################################################
# 処理部分
# #############################################################################

# -----------------------------------------------------------------------------
# 開始メッセージの表示
# -----------------------------------------------------------------------------

echo ""
echo "--------------------------------------------------"
echo "Start Building LAMP Environment."
echo "--------------------------------------------------"
echo ""

# -----------------------------------------------------------------------------
# Apache & Firewall
# -----------------------------------------------------------------------------

# Apacheのインストール
dnf -y install httpd httpd-devel
systemctl start httpd
systemctl enable httpd

# Firewallの設定
firewall-cmd --remove-service=cockpit --permanent
firewall-cmd --remove-service=dhcpv6-client --permanent
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --reload

# -----------------------------------------------------------------------------
# MySQL
# -----------------------------------------------------------------------------

# MySQLのインストール
dnf -y install mysql mysql-server
systemctl start mysqld
systemctl enable mysqld

# -----------------------------------------------------------------------------
# PHP
# -----------------------------------------------------------------------------

# PHPのインストール
dnf -y module install php:remi-8.2
dnf -y install php \
    php-cli \
    php-common \
    php-fpm \
    php-mbstring \
    php-xml \
    php-bcmath \
    php-devel \
    php-gd \
    php-intl \
    php-mysqlnd \
    php-opcache \
    php-pdo \
    php-pear \
    php-pecl-apcu \
    php-pecl-apcu-devel \
    php-pecl-json-post \
    php-pecl-mcrypt \
    php-pecl-mysql \
    php-pecl-xmlrpc \
    php-pecl-zip \
    php-pgsql \
    php-soap \
    php-json

# PHPの設定ファイルのバックアップ
cp /etc/php.ini /etc/php.ini.bak

# タイムゾーンの設定
sed -i -e "s/;date.timezone =/date.timezone = Asia\/Tokyo/g" /etc/php.ini

# メモリの設定
sed -i -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php.ini

# post_max_size の設定
sed -i -e "s/post_max_size = 8M/post_max_size = 128M/g" /etc/php.ini

# upload_max_filesize の設定
sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 128M/g" /etc/php.ini

# Apacheの再起動
systemctl restart httpd

# -----------------------------------------------------------------------------
# 終了メッセージの表示
# -----------------------------------------------------------------------------

echo ""
echo "--------------------------------------------------"
echo "Complete Building LAMP Environment."
echo "--------------------------------------------------"
echo ""
