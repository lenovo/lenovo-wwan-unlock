#! /bin/bash

## modify ModemManager.service to add "--test-low-power-suspend-resume " and " --test-quick-suspend-resume"
SERVICE_FILE="/lib/systemd/system/ModemManager.service"
STRING_LOW_POWER=" --test-low-power-suspend-resume"
STRING_QUICK_SUSPEND=" --test-quick-suspend-resume"
Rplus_check=$(lspci -d :7560)
FM350_check=$(lspci -d :4d75)
RM520_check=$(lspci -d :1007)
EM160R_check=$(lspci -d :100d)
CURRENT_CONFIG=$(cat "$SERVICE_FILE")

restart_mm_service=false
function version_ge() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"; }

if [ -n "$Rplus_check" ] || [ -n "$FM350_check" ] || [ -n "$RM520_check" ] || [ -n "$EM160R_check" ]; then
	curmmver=$(mmcli -V)
	first_line=${curmmver%%\n*}
	curmmvernum=$(echo $first_line | cut -d " " -f2)
	stand_ver="1.23.2"
	if version_ge $curmmvernum $stand_ver; then
		if grep -q 'test-quick-suspend-resume' <<< "$CURRENT_CONFIG";then
			echo "test-quick-suspend-resume parameter already exists"
		else
			sudo sed -i "s/\(ExecStart.*\).*/\1${STRING_QUICK_SUSPEND}/g" ${SERVICE_FILE}
			restart_mm_service=true
		fi
		
		if grep -q  'test-low-power-suspend-resume' <<< "$CURRENT_CONFIG";then
			echo "test-low-power-suspend-resume parameter already exists"
		else
			sudo sed -i "s/\(ExecStart.*\).*/\1${STRING_LOW_POWER}/g" ${SERVICE_FILE}
			restart_mm_service=true
		fi

		if [ "$restart_mm_service" == "true" ]
		then
			sudo systemctl daemon-reload
			sudo systemctl restart ModemManager
		fi
	else
		echo "Fix supports ModemManager version greater than 1.23.2 or later only."
	fi
else
	echo "Issue Fix is only applicable for Fibocom L860-GL-16/FM350 and Quectel EM160R-GL/RM520N-GL WWAN module."
fi
