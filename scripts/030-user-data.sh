#!/bin/bash

# install user files
cp -r -p "data/user" "$KODI_SETUP_TMP/userfiles"
chown -R "$KODI_USERNAME:$KODI_USERNAME" "$KODI_SETUP_TMP/userfiles"
cp -f -r -p "$KODI_SETUP_TMP/userfiles/." "$KODI_USER_HOME"
rm -rf "$KODI_SETUP_TMP/userfiles"

# install profile user files
if [ -n "$KODI_SETUP_PROFILE" ] && [ -d "profiles/$KODI_SETUP_PROFILE/data/user" ]
then
	cp -r -p "profiles/$KODI_SETUP_PROFILE/data/user" "$KODI_SETUP_TMP/profile_userfiles"
	chown -R "$KODI_USERNAME:$KODI_USERNAME" "$KODI_SETUP_TMP/profile_userfiles"
	cp -f -r -p "$KODI_SETUP_TMP/profile_userfiles/." "$KODI_USER_HOME"
	rm -rf "$KODI_SETUP_TMP/profile_userfiles"
fi

