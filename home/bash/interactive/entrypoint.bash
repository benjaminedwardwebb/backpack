# entrypoint.bash
# The entrypoint script executed when starting a new shell.
#
# This is the final call made in my bashrc file, after sourcing all other shell
# and bash code. Currently, it simply creates a new tmux session on what
# should be an already running tmux server started by systemd. This is
# conditional, since for certain cases (e.g., a non-interactive shell) we
# don't need to run inside a tmux session.
# TODO bash: Find a way to `tmux detach-client -E "NO_TMUX=true bash"` that actually works.

# This entrypoint is called by every shell run as my user. It's important
# that it run successfully, or it can cause surprising errors in
# circumstances where it's not immediately obvious a shell is being
# invoked (e.g., when a user logs in from the display manager).
#
# I use tmux as a terminal multiplexer inside of interactive bash shells.
# To avoid failure or the creation of an unnecessary tmux session, the
# following conditionals gate the tmux invocation.
#
# 	dependency bash: Skip the entrypoint if `bash` is not available
# 	in the shell's PATH. While it is slightly bizarre for a bash shell to
# 	not have a bash executable itself in its PATH, it's technically
# 	possible.
#
# 	dependency which: Skip the entrypoint if `which` is not available.
#
# 	which bash > /dev/null: Skip the entrypoint if the `which bash`
# 	command fails for any reason. This command is used in the next
# 	condition to literally test that an invocation of bash succeeds,
# 	beyond merely testing if it is available to invoke.
#
# 	$(which bash) -c true: Skip the entrypoint if this test invocation of
# 	bash fails. Here bash is invoked with the `true` command, which should
# 	do nothing, successfully (see `man true`).
#
# 	dependency tmux: Skip the entrypoint if `tmux` is not available.
# 	Currently, this entrypoint is synonymous with staring a new tmux
# 	session.
#
# 	[ "$TERM" != "dumb" ]: Skip the entrypoint when an Ubuntu user logs in from the
# 	display manager and an X session is started with a terminal where the
# 	TERM variable is set to "dumb".
#
# 	[[ "$-" =~ "i" ]]: Skip the entrypoint when the shell is non-interctive.
#
# 	[[ -z "${PYEND_DIR+set}" ]]: Skip the entrypoint when running inside
# 	of a poetry shell.
# 	See: https://github.com/python-poetry/poetry/issues/2774
# 	TODO bash: I encountered issues with tmux and Python's poetry virtual environment tool a while back, but I can't remember exactly what they were.
#
# 	[ "$NO_ENTRY" = "true" ]: Skip the entrypoint if the environment
# 	variable NO_ENTRY is set to "true". This is simply an off switch in
# 	case a shell needs to be invoked without the entrypoint function or
# 	tmux for debugging purposes.
#
# Note these conditionals rely on my custom `dependency` command, which is
# a very simple wrapper around the `command` command that is defined in my
# custom `core` bash module. Therefore, loading this module is also an
# implicit dependency of the entrypoint function and a theoretical point
# of failure.
#
# Other commands from this `core` module may be used in the entrypoint
# function (e.g., `log`) and are not explicitly tested by these
# conditionals.
#
# Finally, the last major assumption (that is enumerated here in these
# comments, at least) made by this script is that it is executed inside a
# conventional bash shell. This bash shell is also expected to be version
# 5+, since I only test this on whatever the latest version of bash is
# that I run in my day to day usage. I avoid testing any bash builtins
# here, since these checks are already paranoid enough.
__shell_entrypoint() {
	if dependency bash &&
		dependency which &&
		which bash > /dev/null &&
		$(which bash) -c true &&
		dependency tmux &&
		[ "$TERM" != "dumb" ] &&
		[[ -z "${PYENV_DIR+set}" ]] &&
		[ "$NO_ENTRY" != "true" ];
	then
		log "The dependencies for the entrypoint function are satisfied."

		# For debugging purposes only, I log if prior tmux sessions exist.
		if tmux list-sessions > /dev/null; then
			log "Existing tmux sessions were found with tmux list-session."
		else
			log "No tmux sessions were found with tmux list-session."
		fi

		# Each element of this command has a purpose.
		#
		# 	tmux new-session -t "$USER-$$": Creates a new tmux session for
		# 	the shell. The session is named (-t) after the username and
		# 	the parent shell's process ID.
		# 	See: man tmux | less -p "new-session \["
		#
		# 	> /dev/null 2>&1: This redirects stdout to /dev/null and then
		# 	redirects stderr to stdout. This is used to silence any warnings
		# 	the tmux new-session command may generate. Specifically, it
		# 	silences a message about nesting tmux sessions when a new tmux
		# 	pane is created and its shell invokes the `tmux new-session`
		# 	command below. Thankfully, tmux is smart and does not actually
		# 	nest a session in the new pane, but does warn the user about it.
		#
		# 	&& exit: This exits the parent shell when the new tmux session
		# 	ends. This gives a smoother user experience when running `exit` to
		# 	exit the shell. Without it, the user would return to the parent
		# 	shell and have to call `exit` again to close the terminal.
		# 	See: man builtins | less -p "exec "
		#
		# This has the unfortunate side-effect of creating a few extra
		# processes each time a shell invokes this entrypoint function. There
		# is a process for the original shell the terminal creates, a process
		# for the invocation of `tmux new-session`, and a process for the
		# shell invoked by the tmux session that the user interacts with.
		#
		# The parent process chain is also not totally clear, because the
		# interactive shell inside the tmux session is parented by the tmux
		# server instead of the original shell that creates the new tmux
		# session.
		#
		# I tried to avoid this side-effects by using `exec` to start the new
		# tmux session, but I couldn't get it to work. The shell would always
		# immediately exit for some unclear reason.
		tmux new-session -t "$USER-$$" > /dev/null 2>&1 && exit
	fi
}

__shell_entrypoint
