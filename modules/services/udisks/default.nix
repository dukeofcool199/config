{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.udisks;
in
{
  options.jenkos.services.udisks = with types; {
    enable =
      mkBoolOpt false "enable udisks with supporting utilities?";
  };

  config = mkIf cfg.enable {
    services.udisks2.enable = true;
    environment.systemPackages = with pkgs; [
      udiskie
      ntfs3g
    ];
  };
}
