# LAMP Builder

## Tested Linux Distributions

* AlmaLinux 9.2

## About

This builder installs the following set of modules

* Apache
* MySQL
* PHP

This Builder configure the following PHP settings

* date.timezone = Asia/Tokyo
* memory_limit = 512M
* post_max_size = 128M
* upload_max_filesize = 128M

This Builder configure the following Firewall settings

* Allow HTTP
* Allow HTTPS
* Remove Cockpit Service
* Remove dhcpv6-client Service

## Usage

Execute the following command as a user with root privileges.

```
curl -s https://raw.githubusercontent.com/Takeru-Yamamoto/LAMP-Builder/master/script.bash | bash
```