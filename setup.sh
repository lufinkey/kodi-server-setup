#!/bin/bash

tmp_dir="/tmp/kodi-server-setup"

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



echo "NOTICE: This script was created to set up a FRESH ubuntu server install with Kodi, Steam, EmulationStation, and various emulators"
echo "This process may overwrite several configuration files for these programs"
echo ""

# Get username
read -p "Enter the name of the user that will run kodi: " username
user_id=$(id -u "$username")
if [ -z "$user_id" ]
then
	echo "the user \"$username\" does not exist"
	exit 1
fi

# Enter script directory
base_dir=$(dirname "${BASH_SOURCE[0]}")
full_base_dir=$(fullpath "$base_dir")
cd "$full_base_dir"

# Create directories
mkdir -p "$tmp_dir"

# Install pre-setup packages
apt-get install -y $(cat "lists/pre-setup-install.txt")
# Remove unneeded packages
apt-get -y remove $(cat "lists/to-be-removed.txt")

# Install PPAs
ppas=($(cat "lists/ppas.txt"))
for ppa in "${ppas[@]}"
do
	add-apt-repository -y "$ppa"
done
apt-get update

# Install user files
cp -r userfiles "$tmp_dir/userfiles"
chown -R "$username:$username" "$tmp_dir/userfiles"
userhome=$(getent passwd "$username" | cut -d: -f6)
if [ ! -d "$userhome" ]
then
	echo "User home directory $userhome does not exist. Exiting..."
	exit 1
fi
cp -f -r -p "$tmp_dir/userfiles/." "$userhome"

# Install post-setup packages
apt-get install -y $(cat "lists/post-setup-install.txt")
# Download/install my repos
cd "$tmp_dir"
git clone https://github.com/lufinkey/kodi-openbox
git clone https://github.com/lufinkey/wifi-password
# Install kodi-openbox
cd "$tmp_dir/kodi-openbox"
./build.sh
dpkg -i kodi-openbox.deb
# Install wifi-password
cd "$tmp_dir/wifi-password"
cp "wifi-password" "/usr/local/bin/wifi-password"
cd "$full_base_dir"

# Install packages with prompts
echo ""
echo "The following packages will have install prompts"
read -n 1 -s -p "Press any key to continue..."
echo ""
apt-get install $(cat "lists/prompt-install.txt")

# Install optional packages?
echo ""
echo "The following packages are optional:"
cat "lists/optional-install.txt"
echo ""
optional_choice=
while [ "$optional_choice" != "y" ] && [ "$optional_choice" != "n" ] && [ "$optional_choice" != "c" ]
do
	read -p "Should these be installed? (y=yes, n=no, c=choose): " optional_choice
done
if [ "$optional_choice" == "y" ]
then
	apt-get install $(cat "lists/optional-install.txt")
elif [ "$optional_choice" == "c" ]
then
	optional_packages=($(cat "lists/optional-install.txt"))
	for package in "${optional_packages[@]}"
	do
		echo ""
		package_choice=
		while [ "$package_choice" != "y" ] && [ "$package_choice" != "n" ]
		do
			read -p "install $package? (y/n): " package_choice
		done
		if [ "$package_choice" == "y" ]
		then
			apt-get install "$package"
		fi
	done
fi

# Upgrade packages
apt-get upgrade

# Set autologin user and session
autologin_conf=$(
	cat <<EOF
[SeatDefaults]
autologin-user=${username}
autologin-session=kodi-openbox
EOF
)
echo "$autologin_conf" > /etc/lightdm/lightdm.conf.d/50-autologin.conf

# Cleanup
rm -rf "$tmp_dir"
