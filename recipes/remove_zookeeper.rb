# This recipe will remove the current installation of zookeeper
download_destination = node['kafka']['zookeeper']['download_destination'] # /tmp/zookeeper-3.4.12.tar.gz
zookeeper_parent_dir = node['kafka']['zookeeper']['parent_dir'] # /zookeeper
zookeeper_dataDir = node['kafka']['zookeeper']['dataDir'] # /zookeeper/dataDir
zookeeper_dataLogDir = node['kafka']['zookeeper']['dataLogDir'] # /zookeeper/dataLogDir
zookeeper_logs_dir = node['kafka']['zookeeper']['logs_dir'] # /zookeeper/logs
zookeeper_opt_dir = "/opt/zookeeper"

# stop zookeeper service
service 'zookeeper' do
  action :stop
end

[zookeeper_parent_dir, zookeeper_dataDir, zookeeper_dataLogDir, zookeeper_logs_dir, zookeeper_opt_dir].each do |dir|
  directory dir do
    action :delete
    recursive true
  end
end
  
# remove zookeeper tarball
file download_destination do
  action :delete
end

# remove sysvinit script
file '/etc/rc.d/init.d/zookeeper' do
  action :delete
end
