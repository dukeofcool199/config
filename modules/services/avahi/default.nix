{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.printing;
in
{
  options.jenkos.services.avahi = with types; {
    enable =
      mkBoolOpt false "enable avahi?";
  };

  config = mkIf cfg.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns = true;
        openFirewall = true;
      };
    };
  };
}
