{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.networking;
  webPorts = optParams cfg.isWebServer [ 80 443 ] [ ];
in
{
  options.jenkos.networking = with types; {
    enable = mkBoolOpt false "enable networking?";
    isWebServer = mkBoolOpt false "is this for server applications?";

  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      firewall = {
        trustedInterfaces = [ "vboxnet0" ];
        enable = true;
        allowPing = false;
        allowedTCPPorts = webPorts;
      };

    };


  };
}
