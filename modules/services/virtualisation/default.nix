{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.virtualisation;
in
{
  options.jenkos.services.virtualisation = with types; {
    docker = mkBoolOpt false "enable docker";
    arion = mkBoolOpt false "enable arion for use with docker/podman";
    podman = mkBoolOpt false "enable podman";
    vmware = mkBoolOpt false "enable vmware";
    virtualbox = mkBoolOpt false "enable virtualbox";
  };

  config = {
    environment.systemPackages = if cfg.arion then [ pkgs.arion ] else [ ];
    virtualisation = {
      vmware = {
        host = {
          enable = cfg.vmware;
        };
      };
      virtualbox = {
        host = {
          enable = cfg.virtualbox;
          enableExtensionPack = cfg.virtualbox;
        };
        guest = {
          enable = cfg.virtualbox;
          x11 = cfg.virtualbox;
        };
      };
      docker = {
        enable = cfg.docker;
      };
      podman = {
        enable = cfg.podman;
        defaultNetwork = {
          dnsname = {
            enable = cfg.podman;
          };
        };
      };
    };

  };
}
