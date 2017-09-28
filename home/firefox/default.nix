{ config, pkgs, lib, ... }:

# Some one-time manual steps required:
#
#   - set default search engine from Google to Duck Duck Go at about:preferences#search;
#   - enable browser add-ons that are installed via the Nix expressions below;
#   - generate vimium configuration by running ./local in the vimium
#   directory, and then importing the generated file at
#   ./local/share/firefox/vimium/vimium-options.json into vimium on its
#   options page in firefox;
#
# there is no easy way to automate these steps with Nix or Home-Manager.
{
  programs.firefox.enable = true;
  programs.firefox.extensions =
    with pkgs.nur.repos.rycee.firefox-addons; [
      vimium
      browserpass
    ];
  programs.browserpass.enable = true;
  programs.browserpass.browsers = [ "firefox" ];
  programs.firefox.profiles = {
    benjaminedwardwebb = {
      id = 0;
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      settings = import ./settings.nix;
      bookmarks = import ./bookmarks.nix;
    };
  };

  # Persist browser bookmarks to a JSON file under XDG_DATA_HOME.
  #
  # This allows other applications that access the internet to reuse them,
  # provided they are configured to read from the created JSON file.
  #
  # The bookmarks set is transformed slightly before persisting. The set is
  # converted to a list. For example, the following nix set is persisted as
  # the following JSON array.
  #
  #   // nix
  #   {
  #     duckduckgo: {
  #       keyword: "duckduckgo";
  #       url = "https://duckduckgo.com/?q=%s";
  #     };
  #   }
  #
  #   // JSON
  #   [
  #     {
  #       "keyword": "duckduckgo",
  #       "url": "https://duckduckgo.com/?q=%s"
  #     }
  #   ]
  #
  # This transformed JSON is a slightly more natural data representation for
  # other applications to consume.
  #
  # Conveniently, this transformation is done by the Home Manager firefox
  # module itself, so we only need to reference the setting here.
  xdg.dataFile."firefox/bookmarks.json".text =
    builtins.toJSON config.programs.firefox.profiles.benjaminedwardwebb.bookmarks;
}
