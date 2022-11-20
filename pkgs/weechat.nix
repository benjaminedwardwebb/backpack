self: super:

# See: https://nixos.wiki/wiki/Weechat
{
  weechat = super.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with super.weechatScripts; [
        weechat-matrix
        wee-slack
      ];
    };
  };
}
