#!/bin/bash

# add keys
apt_keys=($(cat "data/lists/apt-keys.txt"))
for apt_key in "${apt_keys[@]}"
do
	wget -q -O - "$apt_key" | apt-key add -
done

# add repositories
apt_repos=($(cat "data/lists/apt-repos.txt"))
for apt_repo in "${apt_repos[@]}"
do
	add-apt-repository -y "$apt_repo"
done

# install sources
cd "data/apt-sources"
apt_sources=(*)
cd "$KODI_SETUP_HOME"
for apt_source in "${apt_sources[@]}"
do
	cp -f "data/apt-sources/$apt_source" "/etc/apt/sources.list.d/$apt_source"
done
apt-get update

