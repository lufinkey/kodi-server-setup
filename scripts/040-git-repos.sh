#!/bin/bash

# Download/install my repos
cd "$KODI_SETUP_TMP"
git clone https://github.com/lufinkey/kodi-openbox
git clone https://github.com/lufinkey/random-tools

# Install kodi-openbox
cd "$KODI_SETUP_TMP/kodi-openbox"
./build.sh
dpkg -i kodi-openbox.deb
# Install random-tools
cd "$KODI_SETUP_TMP/random-tools"
./install.sh
