{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.networking;
  webPorts = optParams cfg.isWebServer [ 80 443 ] [ ];
in
{
  options.jenkos.networking = with types; {
    enable = mkBoolOpt true "enable networking?";
    enableFirewall = mkBoolOpt true "enable firewall?";
    isWebServer = mkBoolOpt false "is this for server applications?";
    allowedTcpPorts = mkOpt (listOf number) [ ] "list of additional allowed TCP ports";
    allowedUdpPorts = mkOpt (listOf number) [ ] "list of additional allowed UDP ports";

  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      firewall = {
        trustedInterfaces = [ "vboxnet0" ];
        enable = cfg.enableFirewall;
        allowPing = false;
        allowedTCPPorts = webPorts ++ cfg.allowedTcpPorts;
        allowedUDPPorts = cfg.allowedUdpPorts;
      };

    };


  };
}
