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

## modify ModemManager.service to delete "--test-low-power-suspend-resume " and " --test-quick-suspend-resume"
SERVICE_FILE="/lib/systemd/system/ModemManager.service"
STRING_LOW_POWER=" --test-low-power-suspend-resume"
STRING_QUICK_SUSPEND=" --test-quick-suspend-resume"
Rplus_check=$(lspci -d :7560)
FM350_check=$(lspci -d :4d75)
RM520_check=$(lspci -d :1007)
EM160R_check=$(lspci -d :100d)
CURRENT_CONFIG=$(cat "$SERVICE_FILE")

restart_mm_service=false

if [ -n "$Rplus_check" ] || [ -n "$FM350_check" ] || [ -n "$RM520_check" ] || [ -n "$EM160R_check" ]; then
	if grep -q 'test-quick-suspend-resume' <<< "$CURRENT_CONFIG";then
		sudo sed -i "s/${STRING_QUICK_SUSPEND}//g" ${SERVICE_FILE}
		restart_mm_service=true
	fi
	if grep -q 'test-low-power-suspend-resume' <<< "$CURRENT_CONFIG";then
		sudo sed -i "s/${STRING_LOW_POWER}//g" ${SERVICE_FILE}
		restart_mm_service=true
	fi

	if [ "$restart_mm_service" == "true" ]
	then
		sudo systemctl daemon-reload
		sudo systemctl restart ModemManager
	fi
fi

echo "fcc unlock package is uninstalled"
### Exit script
exit 0
