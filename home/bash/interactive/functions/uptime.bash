if dependency uptime && dependency sed; then
  function uptime {
    local first_argument="$1"
    local uptime_executable="$(which uptime)"
    if [[ $first_argument == "days" ]]; then
      # parse uptime up until the first comma
      $uptime_executable | sed -E 's/.*(up [^,]*),.*/\1/g'
    else
      $uptime_executable
    fi
  }
fi
