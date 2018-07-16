cd /tmp/kafka-manager

while [ ! -f /tmp/kafka-manager/target/universal/kafka-manager*.zip ]
do 
  sbt clean dist
done
