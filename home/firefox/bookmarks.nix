# Browser bookmarks and search engines are configured here.
#
# Each bookmark's keyword should be identical to attribute name used
# to define it in the set. For example:
#
#   duckduckgo = {
#     keyword = "duckduckgo";
#     ...
#   };
#
# Bookmark keywords should be unique, so that they can be used
# effectively.
#
# Additionally, host-specific bookmarks are loaded and will override
# bookmarks configured here if there are duplicates. Using identical
# keywords and attribute names helps simplify this merge.
#
# Finally, these bookmarks are persisted to XDG_DATA_HOME so they can
# be reused by other applications that access the internet.
let
  hostSpecificBookmarksFile = ~/host/vm-Benjamin-Webb/sync/firefox/bookmarks.nix;
  hostSpecificBookmarks =
    if builtins.pathExists hostSpecificBookmarksFile
    then import hostSpecificBookmarksFile
    else { };
in
{
  duckduckgo = {
    keyword = "duckduckgo";
    url = "https://duckduckgo.com/?q=%s";
    name = "DuckDuckGo";
  };
  go = {
    keyword = "go";
    url = "https://duckduckgo.com/?q=%s";
    name = "DuckDuckGo";
  };
  wiki = {
    keyword = "wiki";
    url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
    name = "Wikipedia";
  };
  google = {
    keyword = "google";
    url = "https://www.google.com/search?q=%s";
    name = "Google";
  };
  maps = {
    keyword = "maps";
    url = "https://www.google.com/maps?q=%s";
    name = "Google Maps";
  };
  youtube = {
    keyword = "youtube";
    url = "https://www.youtube.com/results?search_query=%s";
    name = "Youtube";
  };
  github = {
    keyword = "github";
    url = "https://github.com/search?q=%s";
    name = "GitHub";
  };
  nixpkgs = {
    keyword = "nixpkgs";
    url = "https://search.nixos.org/packages?channel=22.05&from=0&size=50&sort=relevance&type=packages&query=%s";
    name = "Nixpkgs";
  };
  "kernel.org" = {
    url = "https://www.kernel.org";
  };
  athleticbrewing = {
    url = "https://athleticbrewing.com/account/login";
  };
  betterrhodes = {
    url = "https://www.betterrhodes.com/account/login";
  };
} // hostSpecificBookmarks
