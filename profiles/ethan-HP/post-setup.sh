#!/bin/bash

base_dir=$(dirname "${BASH_SOURCE[0]}")
cd "$base_dir"
full_base_dir="$PWD"

# Setup ddclient
read -p "Enter your Dynamic DNS password: " -s ddclient_pass
ddclient_conf=$(
	cat <<EOF

use=web, web=dynamicdns.park-your-domain.com/getip
protocol=namecheap
server=dynamicdns.park-your-domain.com
login=iwouldtotallyfuck.me
password=${ddclient_pass}
@, rss-bridge
EOF
)
echo "$ddclient_conf" > /etc/ddclient.conf
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

