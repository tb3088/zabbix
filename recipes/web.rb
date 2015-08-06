
include_recipe "php::default"

node['zabbix']['web']['packages'].each do |pkg|
  package pkg do
    action :install
    notifies :restart, "service[#{node['zabbix']['web']['install_method']}]", :delayed
  end
end

unless node['zabbix']['web']['install_method'].nil?
  include_recipe "zabbix::web_#{node['zabbix']['web']['install_method']}"
end
