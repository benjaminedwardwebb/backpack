# dependency.sh
# A function alias over the POSIX command `command`.
# 
# This is aliased because it is so useful when checking if shell script
# dependencies exist as callable commands in the current shell environment.
# It's used all over this shell codebase.
#
# See: https://pubs.opengroup.org/onlinepubs/9699919799/

# Returns 0 if the dependency exists, 1 if it does not.
# Usage: if dependency <my-command>; then <do x>; fi
dependency() {
  command -v "$1" > /dev/null
}
