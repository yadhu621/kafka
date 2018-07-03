# install java
include_recipe 'kafka:install_java'

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
scala_source_location = node['kafka']['kafka-manager']['scala_source_location'] # https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.rpm
scala_download_location = node['kafka']['kafka-manager']['scala_download_location'] # /tmp

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

# deliver sbt repo file
cookbook_file '/etc/yum.repos.d/sbt.repo' do
  source 'sbt.repo'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# install sbt
package 'sbt' do
  action :install
end

# download kafka-manager source
execute 'download kafka-manager' do
  cwd "#{kafka_manager_download_location}"
  command "git clone #{kafka_manager_source_location}"
  action :run
end

# build kafka-manager from source
execute 'build kafka-manager from source' do
  cwd '/tmp/kafka-manager'
  command 'sbt clean dist'
  action :run
end

# unzip the binary to /opt and rename to kafka-manager
execute 'unzip the kafka binary to /opt' do
  cwd '/opt'
  command 'unzip /tmp/kafka-manager/target/universal/kafka* && mv kafka* /opt/kafka-manager'
  action :run
end

# create kafka-manager directories
[kafka_manager_parent_dir, kafka_manager_log_dir].each do |dir|
  directory dir do
    owner 'kafka-manager'
    group 'kafka-manager'
    mode '0644'
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

