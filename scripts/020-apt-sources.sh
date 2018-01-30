#!/bin/bash

# add keys
apt_keys=($(cat "data/lists/apt-keys.txt"))
profile_apt_keys=()
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/data/lists/apt-keys.txt" ]
then
	profile_apt_keys=($(cat "$KODI_SETUP_PROFILE_HOME/data/lists/apt-keys.txt"))
fi
for apt_key in "${apt_keys[@]}" "${profile_apt_keys[@]}"
do
	wget -q -O - "$apt_key" | apt-key add -
done

# add repositories
apt_repos=($(cat "data/lists/apt-repos.txt"))
profile_apt_repos=()
if [ -n "$KODI_SETUP_PROFILE" ] && [ -f "$KODI_SETUP_PROFILE_HOME/data/lists/apt-repos.txt" ]
then
	profile_apt_repos=($(cat "$KODI_SETUP_PROFILE_HOME/data/lists/apt-repos.txt"))
fi
for apt_repo in "${apt_repos[@]}" "${profile_apt_repos[@]}"
do
	add-apt-repository -y "$apt_repo"
done

# install sources
if [ -d "data/apt-sources" ]
then
	cd "data/apt-sources"
	apt_sources=(*)
	for apt_source in "${apt_sources[@]}"
	do
		cp -f "$apt_source" "/etc/apt/sources.list.d/$apt_source"
	done
	cd "$KODI_SETUP_HOME"
fi

# install profile sources
if [ -n "$KODI_SETUP_PROFILE" ] && [ -d "$KODI_SETUP_PROFILE_HOME/data/apt-sources" ]
then
	cd "$KODI_SETUP_PROFILE_HOME/data/apt-sources"
	apt_sources=(*)
	for apt_source in "${apt_sources[@]}"
	do
		cp -f "$apt_source" "/etc/apt/sources.list.d/$apt_source"
	done
	cd "$KODI_SETUP_HOME"
fi

# update sources
apt-get update
