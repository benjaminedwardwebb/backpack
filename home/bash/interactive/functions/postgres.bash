# Aliases service start/stop/status commands for a brew-installed postgres.
# This is macOS-specific and maybe brew-specific. Commands taken from brew.
if dependency pg_ctl; then
	function postgres {
		local args="$@"

		local first_argument="$1"

		local __postgres="$(which postgres)"
		local __pg_ctl="$(which pg_ctl)"
		
		if [[ $first_argument == "start" ]] || [[ $first_argument == "stop" ]] || [[ $first_argument == "status" ]]; then
			# See `brew info postgresql` for source of command.
			$__pg_ctl -D /usr/local/var/postgres $first_argument
		else
			$__postgres $args
		fi
	}
fi
