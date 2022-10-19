{ config, ... }:

{
  programs.gpg.enable = true;
  programs.gpg.homedir = "${config.xdg.configHome}/gnupg";
  services.gpg-agent.enable = true;
  services.gpg-agent.enableBashIntegration = true;
  services.gpg-agent.enableSshSupport = true;
  # THIS IS A GNUPG KEYGRIP. IT IS NOT SECRET.
  # See: https://gnupg-users.gnupg.narkive.com/q5JtahdV/gpg-agent-what-is-a-keygrip#post1
  # See: https://security.stackexchange.com/a/233112
  services.gpg-agent.sshKeys = [ "C7EEE90914A484917D6DBA03CFD3F88AFEF4EA80" ];
  services.gpg-agent.pinentryFlavor = "gtk2";
  # 43200 seconds is 12 hours.
  services.gpg-agent.defaultCacheTtl = 43200;
  services.gpg-agent.defaultCacheTtlSsh = 43200;
  services.gpg-agent.maxCacheTtl = 43200;
  services.gpg-agent.maxCacheTtlSsh = 43200;
}
