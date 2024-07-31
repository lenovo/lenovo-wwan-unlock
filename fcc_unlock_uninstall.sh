#! /bin/bash

echo "Uninstalling fcc unlock pakage"

if [ -d "/opt/fcc_lenovo" ]
then
        sudo rm -rf /opt/fcc_lenovo
fi

### Identify current OS
OS_UBUNTU="Ubuntu"
OS_FEDORA="Fedora"

source /etc/os-release

if [[ "$NAME" == *"$OS_UBUNTU"* ]]
then
	if [ -d "/usr/lib/x86_64-linux-gnu/ModemManager/fcc-unlock.d" ]
	then
		sudo rm -rf /usr/lib/x86_64-linux-gnu/ModemManager/fcc-unlock.d
	fi
	if [ -e "/usr/lib/libmodemauth.so" ]
	then
		sudo rm -rf /usr/lib/libmodemauth.so
	fi
	if [ -e "/usr/lib/libconfigserviceR+.so" ]
	then
		sudo rm -rf /usr/lib/libconfigserviceR+.so
	fi
	if [ -e "/usr/lib/libconfigservice350.so" ]
	then
		sudo rm -rf /usr/lib/libconfigservice350.so
	fi
	if [ -e "/usr/lib/libmbimtools.so" ]
	then
		sudo rm -rf /usr/lib/libmbimtools.so
	fi
elif [[ "$NAME" == *"$OS_FEDORA"* ]]
then
	if [ -d "/usr/lib64/ModemManager/fcc-unlock.d" ]
	then
		sudo rm -rf /usr/lib64/ModemManager/fcc-unlock.d
	fi
	if [ -e "/usr/lib64/libmodemauth.so" ]
	then
		sudo rm -rf /usr/lib64/libmodemauth.so
	fi
	if [ -e "/usr/lib/libconfigserviceR+.so" ]
	then
		sudo rm -rf /usr/lib/libconfigserviceR+.so
	fi
	if [ -e "/usr/lib/libconfigservice350.so" ]
	then
		sudo rm -rf /usr/lib/libconfigservice350.so
	fi
	if [ -e "/usr/lib/libmbimtools.so" ]
	then
		sudo rm -rf /usr/lib/libmbimtools.so
	fi
else
    exit 0
fi

## Delete SAR config service
if [ -e "/etc/systemd/system/lenovo-cfgservice.service" ]
then
	sudo rm -rf /etc/systemd/system/lenovo-cfgservice.service
fi
sudo systemctl daemon-reload

PACKAGE_DIR=$(dirname "$0")
source "$PACKAGE_DIR"/suspend-fix/install.sh

# Delete the drop-in file if it exists
if [ -f "$MM_DROPIN_DIR/$MM_DROPIN_FILENAME" ]; then
    sudo rm -f "$MM_DROPIN_DIR/$MM_DROPIN_FILENAME"
    sudo systemctl daemon-reload
    sudo systemctl restart ModemManager.service
fi

echo "fcc unlock package is uninstalled"
### Exit script
exit 0
