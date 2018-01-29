#!/bin/bash

# run profile post-setup script
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/post-setup.sh" ]
then
	cd "$KODI_SETUP_PROFILE_HOME"
	"./post-setup.sh"
fi
