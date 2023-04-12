{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.threeDModeling;
in
{
  options.jenkos.utilities.threeDModeling = with types; {
    enable = mkBoolOpt false "enable all my favorite 3d modeling tools?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        freecad
        sweethome3d.application
        sweethome3d.textures-editor
        sweethome3d.furniture-editor
        blender

      ];
  };
}
