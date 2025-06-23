#!/bin/bash
# vim:ts=4:noet

MM_DROPIN_DIR=/etc/systemd/system/ModemManager.service.d
MM_DROPIN_FILENAME="apply-test-option.conf"
MM_SUSPEND_FIX_DIR=$(dirname "${BASH_SOURCE[0]}")
FCC_LENOVO_DIR=/opt/fcc_lenovo

# Only when certain PCI IDs are found will the drop-in be installed
MM_PIDS=(
	"7560" # Rplus
	"4d75" # FM350
	"1007" # RM520
	"100d" # EM160R
)

. "$MM_SUSPEND_FIX_DIR/mm-wrapper.sh"

precheck_test_options() {
	local fully_supported=true
	for topt in "${MM_TEST_OPTIONS[@]}"; do
		if ! support_test_option "$topt"; then
			fully_supported=false
		fi
	done

	# support_test_option will inform the user of any missing test options
	if ! $fully_supported; then
		>&2 echo "ModemManager does not support all test options"
		>&2 echo "Please update your ModemManager"
		exit 1
	fi
}

install_dropin() {
	precheck_test_options

	if [ ! -d "$MM_DROPIN_DIR" ]; then
		echo "Creating drop-in directory $MM_DROPIN_DIR"
		sudo mkdir -p "$MM_DROPIN_DIR"
	fi

	sudo cp -vf "$MM_SUSPEND_FIX_DIR/$MM_DROPIN_FILENAME" "$MM_DROPIN_DIR"
	sudo mkdir -p "$FCC_LENOVO_DIR/suspend-fix"
	sudo cp -vf "$MM_SUSPEND_FIX_DIR/mm-wrapper.sh" "$FCC_LENOVO_DIR/suspend-fix"
	sudo chmod ugo+x "$FCC_LENOVO_DIR/suspend-fix/mm-wrapper.sh"

	sudo systemctl daemon-reload
	sudo systemctl restart ModemManager.service
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
	for pid in "${MM_PIDS[@]}"; do
		if [ -n "$(lspci -d ":$pid")" ]; then
			echo "Found PCI ID $pid, installing the ModemManager drop-in override"
			install_dropin
			exit
		fi
	done

	echo "Modem on this system does not need this fix"
fi
