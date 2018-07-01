
### zookeeper attributes
default['kafka']['zookeeper']['source_location'] = 'http://apache.mirror.anlx.net/zookeeper/zookeeper-3.4.12/zookeeper-3.4.12.tar.gz'
default['kafka']['zookeeper']['download_destination'] = '/tmp/zookeeper-3.4.12.tar.gz'
default['kafka']['zookeeper']['parent_dir'] = '/zookeeper'
default['kafka']['zookeeper']['dataDir'] = '/zookeeper/dataDir'
default['kafka']['zookeeper']['dataLogDir'] = '/zookeeper/dataLogDir'
default['kafka']['zookeeper']['logs_dir'] = '/zookeeper/logs'
default['kafka']['zookeeper']['clientPort'] = 2181
default['kafka']['zookeeper']['snapRetainCount'] = 3
default['kafka']['zookeeper']['purgeInterval'] = 168


### kafka attributes

### kafka-manager attributes

