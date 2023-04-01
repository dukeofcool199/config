{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.gaming.opensource;
in
{
  options.jenkos.gaming.opensource = with types; {
    enable = mkBoolOpt false "install open source games?";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [
      tuxtype
      tuxpaint
      superTux
      superTuxKart
    ];

  };
}

