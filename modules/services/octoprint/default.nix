{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.octoprint;
  port = 80;
in
{
  options.jenkos.services.octoprint = with types; {
    enable = mkBoolOpt false "enable octoprint?";
  };

  config = mkIf cfg.enable {
    services = {
      octoprint = {
        enable = true;
        inherit port;
      };
    };

    networking = {
      firewall = {
        enable = true;
        allowPing = false;
        allowedTCPPorts = [ port ];
      };
    };
  };
}
