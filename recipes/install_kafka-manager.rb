# install java
include_recipe 'kafka::install_java'

###################################################################################
##################### STEPS TO BUILD KAFKA_MANAGER FROM SOURCE ####################
# install scala
# install sbt
# download kafka-manager source to /tmp from github
# build. cd to /tmp/kafka-manager and sbt clean dist
# unzip /tmp/kafka-manager/target/univeral/kafka-manager-1.3.3.17.zip
# mv kafka-manager-1.3.3.17 to /opt 
# rename /opt/kafka-manager-1.3.3.17 to /opt/kafka-manager
###################################################################################

# attributes
kafka_manager_source_location = node['kafka']['kafka-manager']['source_location'] # 'https://github.com/yahoo/kafka-manager.git'
kafka_manager_download_location = node['kafka']['kafka-manager']['download_location'] # '/tmp'
kafka_manager_parent_dir = node['kafka']['kafka-manager']['parent_dir'] # '/kafka/kafka-manager'
kafka_manager_logs_dir = node['kafka']['kafka-manager']['logs_dir'] #'/kafka/kafka-manager/logs'

scala_source_location = node['kafka']['kafka-manager']['scala_source_location'] # https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.rpm
scala_download_location = node['kafka']['kafka-manager']['scala_download_location'] # /tmp

sbt_source_location = node['kafka']['kafka-manager']['sbt_source_location'] # https://sbt.bintray.com/rpm/sbt-1.1.6.rpm
sbt_download_location = node['kafka']['kafka-manager']['sbt_download_location'] # /tmp


# download scala rpm
execute 'download scala rpm' do
  cwd "#{scala_download_location}"
  command "wget #{scala_source_location}"
  action :run
  not_if { ::File.exist?("/tmp/scala-2.12.2.rpm") }
end

# deliver scala install script
cookbook_file '/tmp/install_scala.sh' do
  source 'install_scala.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# install scala ( if not installed already)
execute 'install scala' do
  cwd '/tmp'
  command 'bash install_scala.sh'
  action :run
end

# download sbt rpm
execute 'download sbt rpm' do
  cwd "#{sbt_download_location}"
  command "wget #{sbt_source_location}"
  action :run
  not_if { ::File.exist?("/tmp/sbt-1.1.6.rpm") }
end

# deliver sbt install script
cookbook_file '/tmp/install_sbt.sh' do
  source 'install_sbt.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# install sbt ( if not installed already)
execute 'install sbt' do
  cwd '/tmp'
  command 'bash install_sbt.sh'
  action :run
end

# download kafka-manager source
execute 'download kafka-manager' do
  cwd "#{kafka_manager_download_location}"
  command "git clone #{kafka_manager_source_location} && chown -R kafka:kafka /tmp/kafka-manager"
  action :run
  not_if { ::Dir.exist?("/tmp/kafka-manager") }
end

# deliver sbt install script
cookbook_file '/tmp/build_kafka-manager.sh' do
  source 'build_kafka-manager.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# build kafka-manager from source
execute 'build kafka-manager from source' do
  cwd '/tmp/kafka-manager'
  command 'bash build_kafka-manager.sh'
  action :run
end

# unzip the binary to /opt and rename to kafka-manager
execute 'unzip the kafka binary to /opt' do
  cwd '/opt'
  command 'unzip /tmp/kafka-manager/target/universal/kafka-manager* && mv kafka-manager* /opt/kafka-manager'
  action :run
  # add a NOT_IF guard
end

# create kafka-manager directories
[kafka_manager_parent_dir, kafka_manager_logs_dir].each do |dir|
  directory dir do
    owner 'kafka'
    group 'kafka'
    mode '0755'
    action :create
  end
end

# deliver sysvinit script
cookbook_file '/etc/rc.d/init.d/kafka-manager' do
  source 'sysvinit_kafka_manager'
  owner 'kafka'
  group 'kafka'
  mode '0755'
  action :create
end

# start kafka-manager service
service 'kafka-manager' do
  action [:start, :enable]
end

