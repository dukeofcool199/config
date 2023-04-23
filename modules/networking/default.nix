{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.networking;
in
{
  options.jenkos.networking = with types; {
    enable = mkBoolOpt true "enable networking?";
    enableFirewall = mkBoolOpt true "enable firewall?";
    allowedTcpPorts = mkOpt (listOf number) [ ] "list of additional allowed TCP ports";
    allowedUdpPorts = mkOpt (listOf number) [ ] "list of additional allowed UDP ports";

  };

  config = mkIf cfg.enable {

    jenkos = {
      utilities = {
        networking = enabled;
      };
    };

    networking = {
      networkmanager.enable = true;
      firewall = {
        trustedInterfaces = [ "vboxnet0" ];
        enable = cfg.enableFirewall;
        allowPing = false;
        allowedTCPPorts = cfg.allowedTcpPorts;
        allowedUDPPorts = cfg.allowedUdpPorts;
      };

    };


  };
}
