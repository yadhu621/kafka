
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
default['kafka']['kafka']['source_location'] = 'http://apache.mirror.anlx.net/kafka/1.1.0/kafka_2.12-1.1.0.tgz'
default['kafka']['kafka']['download_destination'] = '/tmp/kafka_2.12-1.1.0.tgz'

default['kafka']['kafka']['parent.dir'] = '/kafka'
default['kafka']['kafka']['log.dirs'] = '/kafka/kafka-logs'

default['kafka']['kafka']['num.partitions'] = 3
default['kafka']['kafka']['offset.topic.replication.factor'] = 3
default['kafka']['kafka']['transaction.state.log.replication.factor'] = 3
default['kafka']['kafka']['transaction.state.log.min.isr'] = 2
default['kafka']['kafka']['log.retention.hours'] = 168
default['kafka']['kafka']['log.segment.bytes'] = 1073741824

### kafka-manager attributes
default['kafka']['kafka-manager']['source_location'] = 'https://github.com/yahoo/kafka-manager.git'
default['kafka']['kafka-manager']['download_location'] = '/tmp'
default['kafka']['kafka-manager']['scala_source_location'] = 'https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.rpm'
default['kafka']['kafka-manager']['scala_download_location'] = '/tmp'
default['kafka']['kafka-manager']['parent_dir'] = '/kafka/kafka-manager'
default['kafka']['kafka-manager']['logs_dir'] = '/kafka/kafka-manager/logs'



