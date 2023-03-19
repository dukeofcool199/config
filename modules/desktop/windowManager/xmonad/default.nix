{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.jenkos.desktop.windowManager.xmonad;
in
{
  options.jenkos.desktop.windowManager.xmonad = with types; {
    enable =
      mkBoolOpt false "Enables or disables xmonad using my configuration";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
      };
      layout = "us";
      xkbVariant = "";
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
        };
      };
    };
  };
}
