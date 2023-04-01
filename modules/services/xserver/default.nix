{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.xserver;
in
{
  options.jenkos.services.xserver = with types; {
    enable =
      mkBoolOpt false "enable xserver?";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
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
