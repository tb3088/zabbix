# Author:: Nacer Laradji (<nacer.laradji@gmail.com>)
# Cookbook Name:: zabbix
# Recipe:: web
#
# Copyright 2011, Efactures
#
# Apache 2.0
#

include_recipe 'apache2::default'
include_recipe 'apache2::mod_php5'

unless node['zabbix']['web']['user']
  node.default['zabbix']['web']['user'] = node['apache']['user']
end

user node['zabbix']['web']['user']


if node['zabbix']['server']['install_method'] == 'source'
zabbix_source 'extract_zabbix_web' do
  branch node['zabbix']['server']['branch']
  version node['zabbix']['server']['version']
  source_url node['zabbix']['server']['source_url']
  code_dir node['zabbix']['src_dir']
  target_dir "zabbix-#{node['zabbix']['server']['version']}"
  install_dir node['zabbix']['install_dir']
  action :extract_only
end

#FIXME huh?
link node['zabbix']['web_dir'] do
  to "#{node['zabbix']['src_dir']}/zabbix-#{node['zabbix']['server']['version']}/frontends/php"
end

#FIXME install in install_dir
directory "#{node['zabbix']['src_dir']}/zabbix-#{node['zabbix']['server']['version']}/frontends/php/conf" do
  owner node['apache']['user']
  group node['apache']['group']
  mode '0755'
  action :create
end
end

#FIXME install in install_dir
# install zabbix PHP config file
template "#{node['zabbix']['src_dir']}/zabbix-#{node['zabbix']['server']['version']}/frontends/php/conf/zabbix.conf.php" do
  source 'zabbix_web.conf.php.erb'
  owner 'root'
  group 'root'
  mode '754'
  variables(
    :database => node['zabbix']['database'],
    :server => node['zabbix']['server']
  )
end

# install vhost for zabbix frontend
web_app node['zabbix']['web']['fqdn'] do
  server_name node['zabbix']['web']['fqdn']
  server_port node['zabbix']['web']['port']
  server_aliases node['zabbix']['web']['aliases']
  docroot node['zabbix']['web_dir']
  not_if { node['zabbix']['web']['fqdn'].nil? }
  php_settings node['zabbix']['web']['php']['settings']
  notifies :restart, 'service[apache2]', :immediately
end

#apache_site '000-default' do
#  enable false
#end
