#!/bin/bash

# ensure script is run as kodi user
script_user=$(whoami)
if [ "$script_user" != "$KODI_USERNAME" ]
then
	echo "running $0 as user $KODI_USERNAME"
	sudo -u "$KODI_USERNAME" KODI_USERNAME="$KODI_USERNAME" KODI_USER_HOME="$KODI_USER_HOME" "$0"
	exit
fi

# enter user home
cd "$KODI_USER_HOME"

# fix screen sleep
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false

# create rom folders
mkdir -p ~/ROMs/Dreamcast
mkdir -p ~/ROMs/Gameboy
mkdir -p ~/ROMs/Gameboy\ Advance
mkdir -p ~/ROMs/Gamecube
mkdir -p ~/ROMs/Genesis
mkdir -p ~/ROMs/NES
mkdir -p ~/ROMs/Nintendo\ 64
mkdir -p ~/ROMs/Nintendo\ DS
mkdir -p ~/ROMs/Playstation
mkdir -p ~/ROMs/Playstation\ 2
mkdir -p ~/ROMs/SNES
mkdir -p ~/ROMs/Wii

# setup google chrome
if [ ! -f ~/.config/google-chrome/.kodi_setup_done ]
then
	echo "You need to configure Google Chrome. Please do the following:"
	echo "    - sign into chrome"
	echo "    - disable syncing"
	echo "    - disable running in background (Settings > Advanced > System)"
	echo "    - install Google Cast for Education extension"
	echo "    - launch and configure Google Cast for Education"
	echo "    - close chrome"
	read -n 1 -s -p "Press any key to launch google chrome..."
	google-chrome "https://chrome.google.com/webstore/detail/google-cast-for-education/bnmgbcehmiinmmlmepibeeflglhbhlea?hl=en-US" &> /dev/null
	touch ~/.config/google-chrome/.kodi_setup_done
fi
