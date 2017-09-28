{ config, pkgs, lib, ... }:

{
  programs.tmux.enable = true;
  programs.tmux.extraConfig = builtins.readFile ./tmux.conf;
  systemd.user.services = {
    # A systemd service for a tmux server.
    #
    # The tmux server is started with the `new-session` command, even though we
    # don't really care about starting a new tmux session but only an instance of
    # the server. This follows the example set by the Arch wiki. I'm not sure why
    # tmux's `start-server` command is not used instead, but I tried it and was
    # not able to get it working successfully. A detached, dummy tmux session will
    # do instead. Note that I adapt my ExecStart command very slightly to use the
    # tmux installed by nix.
    #
    # The tmux session is named after the user (-s %u) and is detached (-d).
    #
    # See: https://wiki.archlinux.org/title/tmux#Autostart_with_systemd
    tmux = {
      Unit = {
        Description = "tmux server";
      };
      Service = {
        Type = "forking";
        WorkingDirectory = "~";
        Environment = "SHELL=/usr/bin/bash";
        ExecStart = "bash -i -c -- /home/%u/.nix-profile/bin/tmux new-session -s %u -d";
        ExecStop = "/home/%u/.nix-profile/bin/tmux kill-session -t %u";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
