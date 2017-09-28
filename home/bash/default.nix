{ config, pkgs, lib, ... }:

let
  functions = import ../../lib/functions.nix;
  isBashFile = path: functions.filenameHasExtension "bash" path;
  concatenateBashFilesRecursively = path:
    let
      files = functions.listFilesRecursively path;
      bashFiles = builtins.filter isBashFile files;
      string = functions.concatenateFiles bashFiles;
    in
    string;
in
{
  programs.bash.enable = true;

  # Initialization for all bash shells, including both interactive and login.
  programs.bash.bashrcExtra =
    concatenateBashFilesRecursively ./lib;

  # Initialization for interactive shells.
  programs.bash.initExtra =
    concatenateBashFilesRecursively ./interactive;

  # Initialization for login shells.
  programs.bash.profileExtra =
    concatenateBashFilesRecursively ./login;
}
