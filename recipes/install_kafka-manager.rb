# install java
include_recipe 'kafka:install_java'

# download scala rpm
execute 'name' do
  cwd '/tmp'
  command 'wget https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.rpm'
  action :run
end
