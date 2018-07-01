
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
default['kafka']['kafka_source_location'] = 'https://www.apache.org/dyn/closer.cgi?path=/kafka/1.1.0/kafka_2.12-1.1.0.tgz'
default['kafka']['kafka_download_destination'] = '/tmp/kafka_2.12-1.1.0.gz'
default['kafka']['kafka']['parent.dir'] = '/kafka'
default['kafka']['kafka']['log.dirs'] = '/kafka/kafka-logs'
default['kafka']['kafka']['num.partitions'] = 3
default['kafka']['kafka']['offset.topic.replication.factor'] = 3
default['kafka']['kafka']['transaction.state.log.replication.factor'] = 3
default['kafka']['kafka']['transaction.state.log.min.isr'] = 2
default['kafka']['kafka']['log.retention.hours'] = 168
default['kafka']['kafka']['log.segment.bytes'] = 1073741824

### kafka-manager attributes

