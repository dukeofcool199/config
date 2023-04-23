{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.embedded.car;
in
{
  options.jenkos.developer.embedded.car = with types; {
    enable = mkBoolOpt false "enable car embedded device devloping tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tunerStudio
    ];
  };

}
