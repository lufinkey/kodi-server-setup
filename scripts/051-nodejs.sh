#!/bin/bash

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs build-essential

npm install -g $(cat "data/lists/nodejs-packages.txt")
