#!/bin/bash

# install user files
if [ -d "data/user" ]
then
	cp -r -p "data/user" "$KODI_SETUP_TMP/userfiles"
	chown -R "$KODI_USERNAME:$KODI_USERNAME" "$KODI_SETUP_TMP/userfiles"
	cp -f -r -p "$KODI_SETUP_TMP/userfiles/." "$KODI_USER_HOME"
	rm -rf "$KODI_SETUP_TMP/userfiles"
fi

# install profile user files
if [ -n "$KODI_SETUP_PROFILE" ] && [ -d "$KODI_SETUP_PROFILE_HOME/data/user" ]
then
	cp -r -p "$KODI_SETUP_PROFILE_HOME/data/user" "$KODI_SETUP_TMP/profile_userfiles"
	chown -R "$KODI_USERNAME:$KODI_USERNAME" "$KODI_SETUP_TMP/profile_userfiles"
	cp -f -r -p "$KODI_SETUP_TMP/profile_userfiles/." "$KODI_USER_HOME"
	rm -rf "$KODI_SETUP_TMP/profile_userfiles"
fi
