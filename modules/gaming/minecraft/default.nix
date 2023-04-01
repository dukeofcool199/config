{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.gaming.minecraft;
in
{
  options.jenkos.gaming.minecraft = with types; {
    enable = mkBoolOpt false "install and setup minecraft?";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [
      pkgs.minecraft
    ];

  };
}

