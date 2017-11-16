#!/bin/bash

apt-get install -y git
apt-get remove -y update-manager

# run profile pre-setup.sh
if [ -n "$KODI_SETUP_PROFILE" ]
then
	if [ -f "$KODI_SETUP_PROFILE_HOME/pre-setup.sh" ]
	then
		cd "$KODI_SETUP_PROFILE_HOME"
		"./pre-setup.sh"
	fi
fi

