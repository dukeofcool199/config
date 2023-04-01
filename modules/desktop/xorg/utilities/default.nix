{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.desktop.xorg.utilities;
in
{
  options.jenkos.desktop.xorg.utilities = with types; {
    enable = mkBoolOpt false "enable all other utilities that make up my desktop environment?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      polybarFull
      brightnessctl
      redshift
      xbindkeys
      xbindkeys-config
      dmenu
      rofi
      unclutter
      xclip
    ];
  };
}
