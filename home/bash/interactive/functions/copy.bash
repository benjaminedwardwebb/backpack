if dependency pbcopy; then
  alias copy="pbcopy"
elif dependency xclip; then
  alias copy="xclip -r -selection clipboard"
fi
