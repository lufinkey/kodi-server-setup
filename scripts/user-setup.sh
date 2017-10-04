#!/bin/bash
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
if [ ! -f ~/.config/google-chrome/.kodi_setup_done ]
then
	echo "You need to configure Google Chrome. Please do the following:"
	echo "    - sign into chrome"
	echo "    - disable syncing"
	echo "    - disable running in background (Settings > Advanced > System)"
	echo "    - install Google Cast for Education extension"
	echo "    - launch and configure Google Cast for Education"
	echo "    - close chrome"
	google-chrome "https://chrome.google.com/webstore/detail/google-cast-for-education/bnmgbcehmiinmmlmepibeeflglhbhlea?hl=en-US" &> /dev/null
	touch ~/.config/google-chrome/.kodi_setup_done
fi

