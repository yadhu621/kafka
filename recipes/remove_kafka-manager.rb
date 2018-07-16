existing_source_with_version = 'kafka-manager-1.3.3.17'

# stop service
service 'kafka-manager' do
  action :stop
end

# remove directory from /tmp
directory "/tmp/#{existing_source_with_version}" do
  action :delete
  recursive true
end

# remove source directory at /opt
directory '/opt/kafka-manager' do
  action :delete
  recursive true
end

# remove sysvinit script
file '/etc/rc.d/init.d/kafka-manager' do
  action :delete
end