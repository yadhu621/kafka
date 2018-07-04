#!/bin/sh

INSTALLED="$(yum list installed | grep -c scala)"

if [ $INSTALLED -gt 0 ]; then
        echo "scala is already installed"
else
        echo "Installing scala " && sleep 2
        yum install scala-2.12.2.rpm -y
fi
