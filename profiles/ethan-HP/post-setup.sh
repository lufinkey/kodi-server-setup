#!/bin/bash

base_dir=$(dirname "${BASH_SOURCE[0]}")
cd "$base_dir"
full_base_dir="$PWD"

# Setup ddclient
cp -f miscfiles/ddclient.conf /etc/ddclient.conf
chmod 600 /etc/ddclient.conf
sudo apt-get install -y ddclient
ddclient

# lightdm display setup
mkdir -p /etc/lightdm/scripts
cp miscfiles/lightdm-display-setup.sh /etc/lightdm/scripts/
display_setup_conf=$(
	cat <<EOF
[SeatDefaults]
display-setup-script=/etc/lightdm/scripts/lightdm-display-setup.sh
EOF
)
echo "$display_setup_conf" > /etc/lightdm/lightdm.conf.d/51-display-setup.conf
