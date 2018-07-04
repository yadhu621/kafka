# This recipe will remove the current installation of kafka

existing_source_with_version = 'kafka_2.12-1.1.0'

download_destination = node['kafka']['kafka_download_destination']  # /tmp/kafka_2.12-1.1.0.tar.gz
kafka_parent_dir = node['kafka']['kafka']['parent.dir'] ## /kafka
kafka_logdirs = node['kafka']['kafka']['log.dirs'] ## /kafka/kafka-logs
kafka_opt_dir = '/opt/kafka'
kafka_tmp_dir = '/tmp/kafka_2.12-1.1.0'

# stop service
service 'kafka' do
  action :stop
end

# remove directory from /tmp
[
  kafka_parent_dir,
  kafka_logdirs,
  kafka_opt_dir,
  kafka_tmp_dir,
].each do |dir|
  directory dir do
    action :delete
  end
end

# remove kafka tarball
file "/tmp/#{existing_source_with_version}.gz" do
  action :delete
end

# remove sysvinit script
file '/etc/rc.d/init.d/kafka' do
  action :delete
end

# remove kafka user
user 'kafka' do
  action :remove
end


