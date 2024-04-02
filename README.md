# lenovo-wwan-unlock
FCC and DPR unlock for Lenovo PCs

Instructions to perform FCC unlock and SAR config:

-----------------------------------------------------------------
List of Supported WWAN Modules and Systems:

1) WWAN module : Fibocom L860R+  
   Supported systems:
   - ThinkPad X1 Yoga Gen 7
   - ThinkPad X1 Yoga Gen 8
   - ThinkPad X1 Carbon Gen 10
   - ThinkPad X1 Carbon Gen 11
   - ThinkPad T14 Gen 3
   - ThinkPad T14 Gen 4
   - ThinkPad T14s Gen 3
   - ThinkPad T14s Gen 4
   - ThinkPad T16 Gen 1
   - ThinkPad T16 Gen 2

2) WWAN module : Fibocom FM350 5G  
   Supported systems:
   - ThinkPad X1 Yoga Gen 7
   - ThinkPad X1 Yoga Gen 8
   - ThinkPad X1 Carbon Gen 10
   - ThinkPad X1 Carbon Gen 11

3) WWAN module : Quectel RM520N-GL (*Please refer below required Environment)
   Supported systems:
   - ThinkPad X1 Carbon Gen 12
   - ThinkPad X1 2-in-1 Gen 9
   Environment:
   - Kernel version: 6.6 or later
   - ModemManager version: 1.22 or later

4) WWAN module : Quectel EM160R-GL (*Please refer below required Environment)
   Supported systems:
   - ThinkPad X1 Carbon Gen 12
   - ThinkPad X1 2-in-1 Gen 9
   - ThinkPad L14 Gen 5
   - ThinkPad L16 Gen 1
   Environment:
   - Kernel version: 6.5 or later
   - ModemManager version: 1.22 or later

5) WWAN module : Quectel EM061K (*Please refer below required Environment)
   Supported systems:
   - ThinkPad L13 Gen 5
   - ThinkPad L13 2-in-1 Gen 5
   - ThinkPad L14 Gen 5
   - ThinkPad L16 Gen 1
   Environment:
   - Kernel version: 6.5 or later
   - ModemManager version: 1.22 or later

6) WWAN module : Quectel EM05-CN (*Please refer below required Environment) 
   Supported systems:
   - ThinkPad X1 Carbon Gen 12
   Environment:
   - Kernel version: 6.6 or later
   - ModemManager version: 1.21.2 or later

Enablement is done on a Module + System basis. **Systems not listed 
are currently not supported.**

------------------------------------------------------------------------
Tested Operating Systems:
- Ubuntu 22.04 : OK
- Fedora: OK

------------------------------------------------------------------------
**Please follow the procedure below step by step to enable WWAN**

1) Run the `fcc_unlock_setup.sh` script to
   install SAR config package and FCC unlock:
   ```
   chmod ugo+x fcc_unlock_setup.sh
   ./fcc_unlock_setup.sh
   ```
2) Reboot machine (Only needed once)

------------------------------------------------------------------------
Logs can be checked using **one** of the commands below:
- `cat /var/log/syslog | grep -i dpr`
- `journalctl`

------------------------------------------------------------------------
Additional Notes:
- If the Modem disappears after the machine reboots, please
restart it with the `systemctl restart ModemManager` command.

------------------------------------------------------------------------
