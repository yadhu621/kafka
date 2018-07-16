# "sbt clean dist" builds scala projects.
# Chef run fails the first time when it tries to do run sbt clean dist on kafka-manager and exits prematurely.
# To prevent it from exiting and instead make it to try and build again, enclose "sbt clean dist" in a while loop.
# Not elegant, but works.

# cd into the /tmp/kafka-manager that contains the project folder
cd /tmp/kafka-manager

# if zip file exists, then do nothing
if [ -f /tmp/kafka-manager/target/universal/kafka-manager*.zip ]; then 
    echo "Nothing to do. Kafka-manager.zip already available."
else
    # if zip file does not exist, do 'sbt clean dist' until you find the zip file
    while [ ! -f /tmp/kafka-manager/target/universal/kafka-manager*.zip ]
    do 
      sbt clean dist
    done
fi