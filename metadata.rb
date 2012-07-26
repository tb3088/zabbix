maintainer       "Nacer Laradji"
maintainer_email "nacer.laradji@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures zabbix Agent/Server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.35"
supports          "ubuntu", ">= 10.04"
supports          "debian", ">= 6.0"
supports          "redhat", ">= 5.0"
supports          "centos", ">= 5.0"
depends "apache2" ,">= 1.0.8"
depends "database", ">= 1.0.0"
depends "mysql", ">= 1.2.0"
depends "ufw",  ">= 0.6.1"
depends "yum"