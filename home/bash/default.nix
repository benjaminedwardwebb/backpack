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
  concatenateBashDirectoriesRecursively = directories:
    let
      strings = map concatenateBashFilesRecursively directories;
      string = builtins.concatStringsSep "\n" strings;
    in
    string;
in
{
  programs.bash.enable = true;

  # Initialization for interactive and non-interactive bash shells, but not
  # the login shell.
  programs.bash.bashrcExtra =
    concatenateBashFilesRecursively ./lib;

  # Initialization for interactive shells.
  programs.bash.initExtra =
    concatenateBashFilesRecursively ./interactive;

  # Initialization for login shells.
  programs.bash.profileExtra =
    concatenateBashDirectoriesRecursively [
      ./lib
      ./login
    ];
}
