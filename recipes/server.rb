# Author:: Nacer Laradji (<nacer.laradji@gmail.com>)
# Cookbook Name:: zabbix
# Recipe:: server
#
# Copyright 2011, Efactures
#
# Apache 2.0
#

include_recipe 'zabbix'
include_recipe 'zabbix::server_common'
include_recipe "zabbix::_server_#{node['zabbix']['server']['install_method']}"
