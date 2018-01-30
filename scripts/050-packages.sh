#!/bin/bash

# get packages
packages=$(cat "data/lists/packages.txt")
profile_packages=
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/data/lists/packages.txt" ]
then
	profile_packages=$(cat "$KODI_SETUP_PROFILE_HOME/data/lists/packages.txt")
fi

# install packages
if [ -n "$packages" ] || [ -n "$profile_packages" ]
then
	apt-get install -y $packages $profile_packages
fi
