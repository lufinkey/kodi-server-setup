#!/bin/bash

cd "data/bin"
bin_files=(*)
cd "$KODI_SETUP_HOME"
for bin_file in "${bin_files[@]}"
do
	cp -f "$bin_file" "/usr/local/bin/$bin_file"
done

