#attributes
source_location = node['kafka']['zookeeper']['source_location']
download_destination = node['kafka']['zookeeper']['download_destination']
parent_dir = node['kafka']['zookeeper']['parent_dir'] # /zookeeper
data_dir = node['kafka']['zookeeper']['dataDir'] # /zookeeper/dataDir
data_log_dir = node['kafka']['zookeeper']['dataLogDir'] # /zookeeper/dataLogDir
logs_dir = node['kafka']['zookeeper']['logs_dir'] # /zookeeper/logs

# variable hash for zoo.cfg template
my_hash = {
  zookeeper_clientPort: zookeeper_clientPort,
  zookeeper_dataDir: zookeeper_dataDir,
  zookeeper_dataLogDir: zookeeper_dataLogDir,
  zookeeper_snapRetainCount: zookeeper_snapRetainCount,
  zookeeper_purgeInterval: zookeeper_purgeInterval,
}

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
  owner 'zookeeeper'
  group 'zookeeeper'
  mode '0644'
  action :create
end

# unzip and untar
execute 'unzip and untar zookeeper source' do
  cwd '/tmp'
  command "tar xvzf #{download_destination}"
  action :run
end

# move to /opt and rename
execute 'move to /opt and rename' do
  command 'cp -rp /tmp/zookeeper-3.4.12 /opt/ && mv /opt/zookeeper-3.4.12 /opt/zookeeper'
  action :run
end

# create required directories and files
[parent_dir, data_dir, data_log_dir, logs_dir].each do |dir|
  directory dir do
    owner 'zookeeper'
    group 'zookeeper'
    mode '0644'
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

# start service