#!/bin/bash

# Setup ddclient
read -p "Enter your Dynamic DNS password (or hit ENTER to skip): " -s ddclient_pass
if [ -n "$ddclient_pass" ]
then
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
	echo "$ddclient_conf" > "/etc/ddclient.conf"
	chmod 600 "/etc/ddclient.conf"
	sudo apt-get install -y ddclient
	ddclient
fi

set-default-xrandr-output VGA-0

