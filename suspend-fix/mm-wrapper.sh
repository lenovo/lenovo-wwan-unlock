#!/bin/bash
# vim:ts=4:noet

MM_TEST_OPTIONS=(
	"--test-low-power-suspend-resume"
	"--test-quick-suspend-resume"
)

base_execstart() {
	local service_file
	service_file=$(systemctl show --property=FragmentPath ModemManager | cut -d= -f2)
	grep -oP 'ExecStart=\K.*' "$service_file"
}

support_test_option() {
	local topt
	topt="$1"

	if ! grep -q -- "$topt" < <(ModemManager --help); then
		>&2 echo "ModemManager does not support $topt"
		return 1
	fi
}

may_with_test_options() {
	local options=()
	for topt in "${MM_TEST_OPTIONS[@]}"; do
		if support_test_option "$topt"; then
			options+=("$topt")
		fi
	done

	local cmd
	cmd="$(base_execstart) ${options[*]}"
	echo "I will execute: $cmd"
	eval "$cmd"
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
	may_with_test_options
fi
