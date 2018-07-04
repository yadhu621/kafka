#!/bin/sh

INSTALLED="$(yum list installed | grep -c sbt)"

if [ $INSTALLED -gt 0 ]; then
        echo "sbt is already installed"
else
        echo "Installing sbt " && sleep 2
        yum install sbt-1.1.6.rpm -y
fi


