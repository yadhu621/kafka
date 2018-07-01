# attributes
source_location = node['kafka']['zookeeper']['source_location']
download_destination = node['kafka']['zookeeper']['download_destination']
zookeeper_parent_dir = node['kafka']['zookeeper']['parent_dir'] # /zookeeper
zookeeper_dataDir = node['kafka']['zookeeper']['dataDir'] # /zookeeper/dataDir
zookeeper_dataLogDir = node['kafka']['zookeeper']['dataLogDir'] # /zookeeper/dataLogDir
zookeeper_logs_dir = node['kafka']['zookeeper']['logs_dir'] # /zookeeper/logs
zookeeper_clientPort = node['kafka']['zookeeper']['clientPort'] ## 2181
zookeeper_snapRetainCount = node['kafka']['zookeeper']['snapRetainCount'] ## 3
zookeeper_purgeInterval= node['kafka']['zookeeper']['purgeInterval'] ## 168

# variable hash for zoo.cfg template
my_hash = {
  zookeeper_clientPort: zookeeper_clientPort,
  zookeeper_dataDir: zookeeper_dataDir,
  zookeeper_dataLogDir: zookeeper_dataLogDir,
  zookeeper_snapRetainCount: zookeeper_snapRetainCount,
  zookeeper_purgeInterval: zookeeper_purgeInterval,
}

# cleanup previous installation
include_recipe 'kafka::remove_zookeeper'

# create zookeeper system user
user 'zookeeper' do
  comment 'system account for zookeeper'
  shell '/bin/bash'
  system true
  action :create
end

# download source
remote_file download_destination do
  source source_location
  owner 'zookeeper'
  group 'zookeeper'
  mode '0644'
  action :create
end

# unzip and untar
execute 'unzip and untar zookeeper source' do
  cwd '/tmp'
  command "tar xvzf #{download_destination}"
  user 'zookeeper'
  group 'zookeeper'
  umask 022
  action :run
end

# move to /opt and rename
execute 'move to /opt and rename' do
  command 'cp -rp /tmp/zookeeper-3.4.12 /opt/ && mv /opt/zookeeper-3.4.12 /opt/zookeeper'
  action :run
end

# create required directories and files
[zookeeper_parent_dir, zookeeper_dataDir, zookeeper_dataLogDir, zookeeper_logs_dir].each do |dir|
  directory dir do
    owner 'zookeeper'
    group 'zookeeper'
    mode '0755'
    action :create
  end
end

# deliver config file (zoo.cfg)
template '/opt/zookeeper/conf/zoo.cfg' do
  source 'zookeeper_zoo.cfg.erb'
  owner 'zookeeper'
  mode '0644'
  action :create
  variables (my_hash)
end

# deliver sysinit script
cookbook_file '/etc/rc.d/init.d/zookeeper' do
  source 'sysinit_zookeeper'
  owner 'zookeeper'
  group 'zookeeper'
  mode '0755'
  action :create
end

# start service
service 'zookeeper' do
  action [:start, :enable]
end
