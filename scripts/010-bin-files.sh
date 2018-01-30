#!/bin/bash

# install bin files
if [ -d "data/bin" ]
then
	cd "data/bin"
	bin_files=(*)
	for bin_file in "${bin_files[@]}"
	do
		cp -f "$bin_file" "/usr/local/bin/$bin_file"
	done
fi

# install profile bin files
if [ -n "$KODI_SETUP_PROFILE" ] && [ -d "$KODI_SETUP_PROFILE_HOME/data/bin" ]
then
	cd "$KODI_SETUP_PROFILE_HOME/data/bin"
	bin_files=(*)
	for bin_file in "${bin_files[@]}"
	do
		cp -f "$bin_file" "/usr/local/bin/$bin_file"
	done
fi
