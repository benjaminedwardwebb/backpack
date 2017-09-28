# TODO not well tested
# TODO gives stdin recursive grep instead of operating on curdir .; not for ggrep, but it can't recognize that here...
function replace {
  local search="$1"
  local replace="$2"
  ggrep -RlI --color=never "$search" | xargs sed -i "s/$search/$replace/g"
}
