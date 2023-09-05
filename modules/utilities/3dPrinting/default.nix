{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.threeDprinting;
in
{
  options.jenkos.utilities.threeDprinting = with types; {
    enable = mkBoolOpt false "enable all my favorite 3d printing tools?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        slic3r
        cura
      ];
  };
}
