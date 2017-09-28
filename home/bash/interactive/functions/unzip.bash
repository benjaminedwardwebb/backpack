# Usage:
# unzip [file.gz] => gunzip $file.gz
# unzip [args] => unzip $args
function unzip {
  local args="$@"

  local __unzip__executable="$(which unzip)"

  if args_is_gzipped_file $args; then
    gunzip $args
  else
    $__unzip__executable $args
  fi
}
