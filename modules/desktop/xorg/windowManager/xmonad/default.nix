{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.desktop.xorg.windowManager.xmonad;
in
{
  options.jenkos.desktop.xorg.windowManager.xmonad = with types; {
    enable =
      mkBoolOpt false "enable xmonad?";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        # config = ./xmonad.hs;
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
