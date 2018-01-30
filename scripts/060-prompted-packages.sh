#!/bin/bash

# alert user about prompted packages
echo ""
echo "The next packages are going to have install prompts"
read -n 1 -s -p "Press any key to continue..."
echo ""

# get packages
packages=$(cat "data/lists/prompted-packages.txt")
profile_packages=
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/data/lists/prompted-packages.txt" ]
then
	profile_packages=$(cat "$KODI_SETUP_PROFILE_HOME/data/lists/prompted-packages.txt")
fi

# install packages
if [ -n "$packages" ] || [ -n "$profile_packages" ]
then
	apt-get install -y $packages $profile_packages
fi
