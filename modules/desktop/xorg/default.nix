{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.desktop.xorg;
in
{
  options.jenkos.desktop.xorg = with types; {
    basicConfigs = mkBoolOpt false "enable basic configurations for x11 server?";
  };

  config = mkIf cfg.basicConfigs {
    services.xserver = {
      enable = yes;
    };
    environment.variables = {
      XCURSOR_SIZE = "40";
    };
  };
}
