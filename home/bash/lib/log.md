% LOG(1) log 0.0.0
% Ben Webb
% 2022-01-23

# NAME

log - a simple logging function for POSIX shells.

# SYNOPSIS

log [message]

# DESCRIPTION

log writes a message to a dedicated log file found at /tmp/backpack.<shell-process-id>.log.

An ISO-8601 formatted datetime and the shell instance's process id are prefixed to the message written in the log file.
