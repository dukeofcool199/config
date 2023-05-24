{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.sysadmin;
in
{
  options.jenkos.utilities.sysadmin = with types; {
    enable =
      mkBoolOpt false "sysadmin tools?";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [

      gparted
      du-dust
      duf
      sysz
      busybox
      htop
      ncdu
    ];

  };
}
