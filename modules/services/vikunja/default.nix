{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.vikunja;
in
{
  options.jenkos.services.vikunja = with types; {
    enable =
      mkBoolOpt false "enable vikunja?";
  };

  config = mkIf cfg.enable {
    services.vikunja = {
      enable = yes;
      frontendScheme = "http";
      frontendHostname = "browndog";
    };
  };
}
