{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.chat;
in
{
  options.jenkos.utilities.chat = with types; {
    enable =
      mkBoolOpt false "install text/video chat tools?";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      zoom-us
      discord
      element-desktop
      workchat
      weechat
      profanity
      tdesktop
    ];

  };
}
