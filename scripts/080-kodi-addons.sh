#!/bin/bash

# get addon URLs
addon_urls=$(cat "data/lists/kodi-addons.txt")

# create kodi addons folder
kodi_addon_downloads="$KODI_USER_HOME/Downloads/kodi-addons"
rm -rf "$kodi_addon_downloads"
mkdir -p "$kodi_addon_downloads"

# download kodi addons
cd "$kodi_addon_downloads"
addon_counter=0
for addon_url in $addon_urls
do
	wget -N "$addon_url" -O "$addon_counter.zip"
	addon_counter=$(($addon_counter+1))
done
chown -R "$KODI_USERNAME:$KODI_USERNAME" "$kodi_addon_downloads"
