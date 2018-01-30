#!/bin/bash

# install nodejs
curl -sL https://deb.nodesource.com/setup_9.x | bash -
apt-get install -y nodejs build-essential

# get npm packages
npm_packages=$(cat "data/lists/nodejs-packages.txt")
npm_profile_packages=
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/data/lists/nodejs-packages.txt" ]
then
	profile_packages=$(cat "$KODI_SETUP_PROFILE_HOME/data/lists/nodejs-packages.txt")
fi

# install npm packages
if [ -n "$npm_packages" ] || [ -n "$npm_profile_packages" ]
then
	npm install -g $npm_packages $npm_profile_packages
fi
