#!/bin/bash

echo "Copying files and libraries..."

if [ ! -d "/opt/fcc_lenovo" ]
then
        sudo mkdir /opt/fcc_lenovo
fi

# Copy fcc unlock script for MM
sudo tar -zxf fcc-unlock.d.tar.gz -C /usr/lib/ModemManager/
sudo chmod ugo+x /usr/lib/ModemManager/fcc-unlock.d/*

### Copy libraries
sudo cp -rvf libmbimtools.so /usr/lib/
sudo cp -rvf libdpr.so.2.0.1 /usr/lib/

### Copy binary
sudo cp -rvf DPR_Fcc_unlock_service /opt/fcc_lenovo/
sudo chmod ugo+x /opt/fcc_lenovo/*

## Please reboot machine (this will be needed only one for time)##

### Exit script
exit 0
