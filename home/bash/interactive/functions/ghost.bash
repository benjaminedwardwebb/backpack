# Opens a specialized instance of vim and starts its GhostText server.
# See: https://ghosttext.fregante.com/
function ghost {
	local -r __vim=$(which vim)
	$__vim -c 'GhostStart' /tmp/ghost-text-textarea.md
}
