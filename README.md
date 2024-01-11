# lenovo-wwan-unlock
FCC and DPR unlock for Lenovo PCs

Instructions to perform FCC unlock and SAR config:

-----------------------------------------------------------------
List of Supported WWAN Module and systems:

1) WWAN module : Fibocom L860R+
Supported System:
- ThinkPad X1 Yoga Gen 7
- ThinkPad X1 Yoga Gen 8
- ThinkPad X1 Carbon Gen 10
- ThinkPad X1 Carbon Gen 11

2) WWAN module : Fibocom FM350 5G
Supported System:
- ThinkPad X1 Yoga Gen 7
- ThinkPad X1 Yoga Gen 8
- ThinkPad X1 Carbon Gen 10
- ThinkPad X1 Carbon Gen 11

------------------------------------------------------------------------
Operating System:
- Ubuntu 22.04 : OK
- Fedora: OK

------------------------------------------------------------------------
**Please follow below procedure step by step to enable WWAN**

Step-1: Install SAR config package and FCC unlock:
Execute "fcc_unlock_setup.sh" script using ebelow command:
- chmod ugo+x fcc_unlock_setup.sh
- ./fcc_unlock_setup.sh

Step-2: Reboot machine (this is needed only one time)

------------------------------------------------------------------------
Log can be checked below:
Log:  cat /var/log/syslog | grep -i dpr
OR
use "journalctl" command

------------------------------------------------------------------------
Additional Note:
- Please restart Modem using command "systemctl restart ModemManager"
after reboot, if Modem disappears.

------------------------------------------------------------------------
