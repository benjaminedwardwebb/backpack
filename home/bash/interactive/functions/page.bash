# TODO make vimpager fast! find a way to use a distinct, minimal vim runtime
if dependency vimpager && dependency glow && dependency __args; then
  export VIMPAGER_RC="$HOME/.vim/vimpagerrc"
  function page {
    local -r args="$@"
	local -r __vimpager="$(which vimpager)"

    if args_is_markdown_file $args; then
      glow $args
    else
      $__vimpager $args
    fi
  }
elif dependency vimpager; then
  export VIMPAGER_RC="$HOME/.vim/vimpagerrc"
  alias page="vimpager"
elif dependency less; then
  alias page="less"
elif dependency more; then
  alias page="more"
fi
