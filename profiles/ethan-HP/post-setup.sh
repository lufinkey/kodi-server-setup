#!/bin/bash

base_dir=$(dirname "${BASH_SOURCE[0]}")
cd "$base_dir"
full_base_dir="$PWD"

cp -f miscfiles/ddclient.conf /etc/ddclient.conf
chmod 600 /etc/ddclient.conf
sudo apt-get install -y ddclient
ddclient

