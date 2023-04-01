{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.hardware.zsa;
in
{
  options.jenkos.hardware.zsa = with types; {
    enable =
      mkBoolOpt false "enable zsa hardware compatability?";
  };

  config = mkIf cfg.enable {
    services.udev.packages = [ pkgs.zsa-udev-rules ];
  };
}
