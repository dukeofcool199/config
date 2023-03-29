{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.networking;
  ftpPorts = optParams cfg.isFtpServer [ 21 ] [ ];
  webPorts = optParams cfg.isFtpServer [ 80 443 ] [ ];
in
{
  options.jenkos.networking = with types; {
    enable = mkBoolOpt false "enable networking?";
    isWebServer = mkBoolOpt false "is this for server applications?";
    isFtpServer = mkBoolOpt false "is this for server applications?";

  };

  config = mkIf cfg.enable {
    networking = {
      # Enable networking
      networkmanager.enable = true;
      # Open ports in the firewall.
      firewall = {
        trustedInterfaces = [ "vboxnet0" ];
        enable = true;
        allowPing = false;
        allowedTCPPorts = ftpPorts ++ webPorts;
      };

    };


  };
}
