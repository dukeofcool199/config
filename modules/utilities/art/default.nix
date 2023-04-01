{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.art;
in
{
  options.jenkos.utilities.art = with types; {
    enable = mkBoolOpt false "enable all my favorite art  tools?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        blender
        gimp
        gthumb
      ];
  };
}
