['java-1.8.0', 'java-1.8.0-openjdk-devel', 'git', 'tree', 'nano', 'wget'].each do |pkg|
  package pkg do
    action :remove
  end
end