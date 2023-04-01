{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.office;
in
{
  options.jenkos.utilities.office = with types; {
    enable =
      mkBoolOpt false "enable all my favorite office tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice
      gnome.simple-scan
    ];

  };
}
