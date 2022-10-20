# login

This code is loaded by every bash login shell.

It's important that this code does not print to stdout, or it may interfere
with non-interactive shells. For example, printing to stdout in non-interactive
shells will fail `scp` when it's used to access this host.
