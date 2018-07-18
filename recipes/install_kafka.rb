# kafka variables
source_location = node['kafka']['kafka']['source_location']
download_destination = node['kafka']['kafka']['download_destination']

kafka_parent_dir = node['kafka']['kafka']['parent.dir'] ## /kafka
kafka_logdirs = node['kafka']['kafka']['log.dirs'] ## /kafka/kafka-logs
kafka_num_partitions = node['kafka']['kafka']['num.partitions'] ## 3
kafka_offset_topic_replication_factor = node['kafka']['kafka']['offset.topic.replication.factor'] ## 3
kafka_transaction_state_log_replication_factor = node['kafka']['kafka']['transaction.state.log.replication.factor'] ## 3
kafka_transaction_state_log_min_isr = node['kafka']['kafka']['transaction.state.log.min.isr'] ## 2
kafka_log_retention_hours = node['kafka']['kafka']['log.retention.hours'] ## 168
kafka_log_segment_bytes = node['kafka']['kafka']['log.segment.bytes'] ## 1073741824

# variable hash for kafka.server.properties.template
my_hash = {
  kafka_parent_dir: kafka_parent_dir,
  kafka_logdirs: kafka_logdirs,
  kafka_num_partitions: kafka_num_partitions,
  kafka_offset_topic_replication_factor: kafka_offset_topic_replication_factor,
  kafka_transaction_state_log_replication_factor: kafka_transaction_state_log_replication_factor,
  kafka_transaction_state_log_min_isr: kafka_transaction_state_log_min_isr,
  kafka_log_retention_hours: kafka_log_retention_hours,
  kafka_log_segment_bytes: kafka_log_segment_bytes,
}

# create a user for kafka
user 'kafka' do
  comment 'system account for kafka'
  system true
  shell '/bin/bash'
  action :create
end

# deliver kafka source
remote_file download_destination do
  source source_location
  owner 'kafka'
  group 'kafka'
  mode '0644'
  action :create
end

# untar and unzip the source
execute 'untar and unzip the kafka source' do
  cwd '/tmp'
  command "tar zxvf #{download_destination}"
  user 'kafka'
  group 'kafka'
  umask 022
  action :run
  not_if { ::Dir.exist?('/tmp/kafka-2.12-1.1.0') }
end

# copy source to /opt/ and rename from kafka-x.y.zz to kafka
execute 'move kafka source to /opt' do
  command 'cp -rp /tmp/kafka_2.12-1.1.0 /opt/ && mv /opt/kafka_2.12-1.1.0 /opt/kafka'
  action :run
  not_if { ::Dir.exist?('/opt/kafka') }
end

# create kafka-logs folder
[kafka_parent_dir, kafka_logdirs].each do |dir|
  directory dir do
    owner 'kafka'
    group 'kafka'
    mode '0755'
    action :create
    recursive true
  end
end

# deliver config file
template '/opt/kafka/config/server.properties' do
  source 'kafka_server.properties.erb'
  owner 'kafka'
  mode '0644'
  action :create
  variables (my_hash)
end

# deliver sysvinit script
cookbook_file '/etc/rc.d/init.d/kafka' do
  source 'sysvinit_kafka'
  owner 'kafka'
  group 'kafka'
  mode '0755'
  action :create
end

# start kafka service
service 'kafka' do
  action [:start, :enable]
end
