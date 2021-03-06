#
# Cookbook Name:: zabbix
# Attributes:: default

case node['platform_family']
when 'windows'
  if ENV['ProgramFiles'] == ENV['ProgramFiles(x86)']
    # if user has never logged into an interactive session then ENV['homedrive'] will be nil
    default['zabbix']['etc_dir']    = ::File.join((ENV['homedrive'] || 'C:'), 'Program Files', 'Zabbix Agent')
  else
    default['zabbix']['etc_dir']    = ::File.join(ENV['ProgramFiles'], 'Zabbix Agent')
  end
else
  default['zabbix']['etc_dir']      = '/etc/zabbix'
end
default['zabbix']['install_dir']  = '/opt/zabbix'
default['zabbix']['web_dir']      = ::File.join(node['zabbix']['install_dir'], 'web')
default['zabbix']['external_dir'] = ::File.join(node['zabbix']['install_dir'], 'externalscripts')
default['zabbix']['alert_dir']    = ::File.join(node['zabbix']['install_dir'], 'alertscripts')
default['zabbix']['lock_dir']     = '/var/lock/subsys'
default['zabbix']['src_dir']      = '/tmp'
default['zabbix']['log_dir']      = '/var/log/zabbix'
default['zabbix']['run_dir']      = '/var/run/zabbix'

default['zabbix']['login']  = 'zabbix'
default['zabbix']['group']  = 'zabbix'
default['zabbix']['uid']    = nil
default['zabbix']['gid']    = nil
default['zabbix']['home']   = '/home/zabbix'
default['zabbix']['shell']  = '/bin/bash'
