# Usage:
# glow [markdown_file] => glow $markdown_file | less
# glow [args] => glow $args
if dependency glow && dependency less && dependency __args; then
  __glow_executable="$(which glow)"

  function glow {
    local args="$@"

    local style="$THEME_BACKGROUND"

    if args_is_markdown_file $args; then
      $__glow_executable -s $style $args | less -r
    else
      $__glow_executable -s $style $args
    fi
  }
elif dependency glow; then
  unit # glow is glow
elif dependency less; then
  alias glow="less"
else
  alias glow="more"
fi
