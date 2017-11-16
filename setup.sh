#!/bin/bash

tmp_dir="/tmp/kodi-server-setup"

# Ensure root
if [[ $EUID > 0 ]]
then
	echo "please run this script as root/sudo"
	exit 1
fi



function fullpath
{
	cd "$1"
	echo "$PWD"
}

function onkill
{
	kill $(jobs -p)
	rm -rf "$tmp_dir"
	exit 1
}
trap "onkill" SIGINT SIGTERM SIGQUIT

# cd into script directory
base_dir=$(dirname "${BASH_SOURCE[0]}")
cd "$base_dir"
export KODI_SETUP_HOME="$base_dir"



# Show warning
echo "NOTICE: This script was created to set up a FRESH ubuntu server install with Kodi, Steam, EmulationStation, and various emulators"
echo "This process may overwrite several configuration files for these programs"
echo ""



# Select a profile
cd "profiles"
profiles=(*)
cd "$KODI_SETUP_HOME"
if [ ${#profiles[@]} -gt 0 ]
then
	echo "Select a profile, or hit ENTER to continue without a profile"
	profile_counter=0
	for profile in "$profiles"
	do
		echo "$profile_counter: $profile"
		profile_counter=$(($profile_counter+1))
	done
	profile_index=
	read -p "Enter a profile number: " profile_index
	if [ -n "$profile_index" ]
	then
		if ! [[ "$profile_index" =~ ^[0-9]+$ ]]
		then
			echo "$profile_index is not a number"
			exit 1
		elif [ "$profile_index" -ge ${#profiles[@]} ]
		then
			echo "$profile_index is not a valid profile number"
			exit 1
		else
			profile=${profiles[$profile_index]}
		fi
	else
		profile=
	fi
else
	profile=
fi
export KODI_SETUP_PROFILE="$profile"
export KODI_SETUP_PROFILE_HOME="$KODI_SETUP_HOME/profiles/$profile"



# Get username
read -p "Enter the name of the user that will run kodi: " username
user_id=$(id -u "$username")
if [ -z "$user_id" ]
then
	echo "the user \"$username\" does not exist"
	exit 1
fi
userhome=$(getent passwd "$username" | cut -d: -f6)
if [ ! -d "$userhome" ]
then
	echo "User home directory $userhome does not exist. Exiting..."
	exit 1
fi
export KODI_USER_ID="$user_id"
export KODI_USERNAME="$username"
export KODI_USER_HOME="$userhome"



# Get profile properties
if [ -n "$profile" ]
then
	source "$KODI_SETUP_PROFILE_HOME/profile"
fi



# Create directories
mkdir -p "$tmp_dir"
export KODI_SETUP_TMP="$tmp_dir"



# run scripts
cd "scripts"
scripts=(*)
cd "$KODI_SETUP_HOME"
for script in "${scripts[@]}"
do
	echo "running script \"$script\""
	"./scripts/$script"
done



# Upgrade packages
apt-get upgrade

# Cleanup
rm -rf "$tmp_dir"


echo ""
echo "Setup is finished!"
echo "Kodi addons have been downloaded to $userhome/Downloads/kodi-addons"
echo "To install them, run kodi and go to Add-ons > the package icon > Install From Zip > Kodi Addon Downloads and install each addon zip in numerical order"

