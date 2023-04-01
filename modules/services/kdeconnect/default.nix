{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.kdeconnect;
in
{
  options.jenkos.services.kdeconnect = with types; {
    enable = mkBoolOpt false "enable kdeconnect?";

  };
  config = mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };
}
