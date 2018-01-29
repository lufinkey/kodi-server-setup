#!/bin/bash

# Set autologin user and session
autologin_conf=$(
	cat <<EOF
[SeatDefaults]
autologin-user=${KODI_USERNAME}
autologin-session=kodi-openbox
EOF
)
echo "$autologin_conf" > /etc/lightdm/lightdm.conf.d/50-autologin.conf
