# This recipe will remove the current installation of zookeeper

existing_source_with_version = 'zookeeper-3.4.12'

# stop zookeeper service
service 'zookeeper' do
  action :start
end

# remove directory from /tmp
directory "/tmp/#{existing_source_with_version}" do
  action :delete
  recursive true
end

# remove source directory at /opt
directory '/opt/zookeeper' do
  action :delete
  recursive true
end

# remove zookeeper tarball
file "/tmp/#{existing_source_with_version}.tar.gz" do
  action :delete
end

# remove sysvinit script
file '/etc/rc.d/init.d/zookeeper' do
  action :delete
end
