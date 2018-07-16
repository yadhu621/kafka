
# Install each component one after another
include_recipe 'kafka::install_java'
include_recipe 'kafka::install_zookeeper'
include_recipe 'kafka::install_kafka'
include_recipe 'kafka::install_kafka-manager'