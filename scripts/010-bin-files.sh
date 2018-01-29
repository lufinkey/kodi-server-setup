#!/bin/bash

if [ -d "data/bin" ]
then
	cd "data/bin"
	bin_files=(*)
	for bin_file in "${bin_files[@]}"
	do
		cp -f "$bin_file" "/usr/local/bin/$bin_file"
	done
fi
