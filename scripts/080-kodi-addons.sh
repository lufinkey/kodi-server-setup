#!/bin/bash

# get addon URLs
addon_urls=$(cat "data/lists/kodi-addons.txt")
profile_addon_urls=
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/data/lists/kodi-addons.txt" ]
then
	profile_addon_urls=$(cat "$KODI_SETUP_PROFILE_HOME/data/lists/kodi-addons.txt")
fi

# create kodi addons folder
kodi_addon_downloads="$KODI_USER_HOME/Downloads/kodi-addons"
rm -rf "$kodi_addon_downloads"
mkdir -p "$kodi_addon_downloads"

# download kodi addons
cd "$kodi_addon_downloads"
addon_counter=0
for addon_url in $addon_urls $profile_addon_urls
do
	wget -N "$addon_url" -O "$addon_counter.zip"
	addon_counter=$(($addon_counter+1))
done
chown -R "$KODI_USERNAME:$KODI_USERNAME" "$kodi_addon_downloads"
