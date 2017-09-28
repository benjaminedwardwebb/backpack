# Opens a specialized instance of vim and starts its GhostText server.
# See: https://ghosttext.fregante.com/
# TODO in ghost command, should we test dependency of GhostText server?
if dependency vim; then
	function ghost {
		local -r __vim=$(which vim)
		$__vim -c 'GhostStart' /tmp/ghost-text-textarea.md
	}
else
	echo "no vim dependency for ghost command"
fi
