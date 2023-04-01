{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.apps.ardour;
in
{
  options.jenkos.apps.ardour = with types; {
    enable = mkBoolOpt false "enable ardour?";
  };

  config = mkIf cfg.enable {
    environment = {

      systemPackages = with pkgs; [
        ardour
        lsp-plugins
        distrho
        tap-plugins
        noise-repellent
      ];
      variables = {
        LV2_PATH = "/run/current-system/sw/lib/lv2/";
      };
    };
    jenkos.hardware.audio = enabled;
  };
}
