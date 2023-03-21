{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.virtualisation;
in
{
  options.jenkos.services.virtualisation = with types; {
    docker = mkBoolOpt false "enable docker";
    podman = mkBoolOpt false "enable podman";
    vmware = mkBoolOpt false "enable vmware";
    virtualbox = mkBoolOpt false "enable virtualbox";
  };

  config = {
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
