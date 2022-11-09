# Add an alias "copy" that copies stdin to the system's clipboard.
#
# Most of my configuration assumes I'm running Linux, but for certain cases
# it's useful to add support for Darwin, for when I occasionally need to step
# out of a virtual machine at work. This is one of those cases.
if dependency pbcopy; then
  alias copy="pbcopy"
elif dependency xclip; then
  alias copy="xclip -r -selection clipboard"
fi
