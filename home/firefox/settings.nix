# Configure firefox settings available at about:config.
{
  "app.update.auto" = false;
  "browser.startup.homepage" =
    "file://" + (builtins.toString ./home.html);
  "browser.newtabpage.enabled" = false;
  "browser.newtabpage.activity-stream.default.sites" = "";

  # These settings enable the cascade userChrome theme.
  # See: https://github.com/andreasgrafen/cascade#how-to-use-a-userchromecss-theme
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  "layers.acceleration.force-enabled" = true;
  "gfx.webrender.all" = true;
  "svg.context-properties.content.enabled" = true;

  # Enable some privacy-related settings.
  # See: https://theprivacyguide1.github.io/about_config.html 
  "privacy.firstparty.isolate" = true;
  # Resisting fingerprinting sounds cool, but it broke vimium last
  # time I enabled it (duplicate tabs were opened each time a link was
  # opened in a new tab).
  # See: https://github.com/philc/vimium/pull/4000
  # "privacy.resistFingerprinting" = true;
  "privacy.trackingprotection.enabled" = true;
  "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
  "privacy.trackingprotection.socialtracking.enabled" = true;
  "extensions.pocket.enabled" = false;
  "extensions.pocket.site" = "blank";
  "extensions.pocket.oAuthConsumerKey" = "blank";
  "extensions.pocket.api" = "blank";

  # These settings are suggested to improve performance of firefox.
  # See: https://softwarekeep.com/blog/speed-up-firefox-browser
  "browser.download.animateNotifications" = false;
  "security.dialog_enable_delay" = 0;
  "network.prefetch-next" = false;
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;
  "browser.ping-centre.telemetry" = false;
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.hybridContent.enabled" = false;
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.reportingpolicy.firstRun" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
}
