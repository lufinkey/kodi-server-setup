#!/bin/bash

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs build-essential

npm_packages=$(cat "data/lists/nodejs-packages.txt")
if [ -n "$npm_packages" ]
then
	npm install -g "$npm_packages"
fi

