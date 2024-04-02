#! /bin/bash

echo "Copying files and libraries..."

if [ ! -d "/opt/fcc_lenovo" ]
then
        sudo mkdir /opt/fcc_lenovo
fi

### Identify current OS
OS_UBUNTU="Ubuntu"
OS_FEDORA="Fedora"

source /etc/os-release
echo $NAME

if [[ "$NAME" == *"$OS_UBUNTU"* ]]
then
	### Copy fcc unlock script for MM
	sudo tar -zxf fcc-unlock.d.tar.gz -C /usr/lib/x86_64-linux-gnu/ModemManager/
	sudo chmod ugo+x /usr/lib/x86_64-linux-gnu/ModemManager/fcc-unlock.d/*

	### Copy SAR config files
	sudo tar -zxf sar_config_files.tar.gz -C /opt/fcc_lenovo/

	### Copy libraries
	sudo cp -rvf libmodemauth.so /usr/lib/
	sudo cp -rvf libconfigserviceR+.so /usr/lib/
	sudo cp -rvf libconfigservice350.so /usr/lib/
	sudo cp -rvf libmbimtools.so /usr/lib/

elif [[ "$NAME" == *"$OS_FEDORA"* ]]
then
	### Copy fcc unlock script for MM
	sudo tar -zxf fcc-unlock.d.tar.gz -C /usr/lib64/ModemManager/
	sudo chmod ugo+x /usr/lib64/ModemManager/fcc-unlock.d/*

	### Copy SAR config files
	sudo tar -zxf sar_config_files.tar.gz -C /opt/fcc_lenovo/

	ln -s /usr/sbin/lspci /usr/bin/lspci

	### Copy libraries
	sudo cp -rvf libmodemauth.so /usr/lib64/
	sudo cp -rvf libconfigserviceR+.so /usr/lib/
	sudo cp -rvf libconfigservice350.so /usr/lib/
	sudo cp -rvf libmbimtools.so /usr/lib/

	### Copy files for selinux for fedora
	sudo cp -rvf mm_FccUnlock.cil /opt/fcc_lenovo
	sudo cp -rvf mm_dmidecode.cil /opt/fcc_lenovo
	sudo cp -rvf mm_sh.cil /opt/fcc_lenovo
	sudo semodule -i /opt/fcc_lenovo/*.cil

else
    echo "No need to copy files"
    exit 0
fi

### Copy binary
sudo cp -rvf DPR_Fcc_unlock_service /opt/fcc_lenovo/
sudo cp -rvf configservice_lenovo /opt/fcc_lenovo/

## copy and enable service
sudo cp -rvf lenovo-cfgservice.service /etc/systemd/system/.
sudo systemctl daemon-reload
systemctl enable lenovo-cfgservice

### Grant permissions to all binaries and script
sudo chmod ugo+x /opt/fcc_lenovo/*

## Please reboot machine (this will be needed only one for time)##

### Exit script
exit 0
