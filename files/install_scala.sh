#!/bin/sh

INSTALLED="$(yum list installed | grep -c scala)"

if [ $INSTALLED -gt 0 ]; then
        echo "scala is already installed"
else
        echo "Installing scala " && sleep 2
        yum install scala -y
fi
