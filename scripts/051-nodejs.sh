#!/bin/bash

# install nodejs
curl -sL https://deb.nodesource.com/setup_9.x | bash -
apt-get install -y nodejs build-essential

# install npm packages
npm_packages=$(cat "data/lists/nodejs-packages.txt")
if [ -n "$npm_packages" ]
then
	npm install -g "$npm_packages"
fi
