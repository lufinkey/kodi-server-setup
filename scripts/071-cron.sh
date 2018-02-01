#!/bin/bash

# install cron jobs
if [ -d "data/cron" ]
then
	cd "data/cron"
	cronjobs=(*)
	for cronjob in "${cronjobs[@]}"
	do
		cp -f "$cronjob" "/etc/cron.d/$cronjob"
	done
	cd "$KODI_SETUP_HOME"
fi

# install profile cron jobs
if [ -n "$KODI_SETUP_PROFILE" ] && [ -d "$KODI_SETUP_PROFILE_HOME/data/cron" ]
then
	cd "$KODI_SETUP_PROFILE_HOME/data/cron"
	cronjobs=(*)
	for cronjob in "${cronjobs[@]}"
	do
		cp -f "$cronjob" "/etc/cron.d/$cronjob"
	done
	cd "$KODI_SETUP_HOME"
fi
