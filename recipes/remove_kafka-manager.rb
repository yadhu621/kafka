existing_source_with_version = 'kafka-manager-1.3.3.17'

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

# remove zookeeper tarball
file "/tmp/#{existing_source_with_version}.zip" do
  action :delete
end