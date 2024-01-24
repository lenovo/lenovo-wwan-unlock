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

3) WWAN module : Fibocom FM350 5G  
   Supported systems:
   - ThinkPad X1 Yoga Gen 7
   - ThinkPad X1 Yoga Gen 8
   - ThinkPad X1 Carbon Gen 10
   - ThinkPad X1 Carbon Gen 11

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
