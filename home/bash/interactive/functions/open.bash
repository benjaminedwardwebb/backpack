# TODO be more specific about the contract of this open function
# Usage:
# open [file] => open the file in the system's window manager
case $system in
  Darwin)
    unit # open is open
    ;; 
  Linux)
    function open {
      local args="$@"
      browse "$args"
    }
    ;;
esac
