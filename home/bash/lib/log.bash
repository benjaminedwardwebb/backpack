# log.sh
# A simple logging function for POSIX shells.
#
# TODO bash: research how to disambiguate shells with $$ and $!; see https://pubs.opengroup.org/onlinepubs/007904975/utilities/xcu_chap02.html
# https://pubs.opengroup.org/onlinepubs/9699919799/
log() {
	__log_date=$(date -u "+%Y-%m-%dT%H:%M:%S+00:00")
	__log_process_id="$$"
	__log_file="/tmp/shell.$__log_process_id.log"
	__log_message="$@"
	__log_line="$__log_date $__log_process_id $__log_message"

	echo "$__log_line" >> $__log_file

	unset __log_date
	unset __log_process_id
	unset __log_file
	unset __log_message
	unset __log_line
}

log::main() {
	__log_process_id="$$"
	__log_file="/tmp/shell.$__log_process_id.log"

	echo "this shell (process $$) logs to $__log_file"

	unset __log_process_id
	unset __log_file
}

log::main
