{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.virtualisation;
in
{
  options.jenkos.services.virtualisation = with types; {
    docker = mkBoolOpt false "enable docker";
    docker-rootless = mkBoolOpt false "enable docker";
    arion = mkBoolOpt false "enable arion for use with docker/podman";
    podman = mkBoolOpt false "enable podman";
    vmware = mkBoolOpt false "enable vmware";
    virtualbox = mkBoolOpt false "enable virtualbox";
    vagrant = mkBoolOpt false "enable vagrant";
    waydroid = mkBoolOpt false "enable waydroid";
    virtualboxUsers = mkOpt (listOf str) [ ] "users to be added to virtualbox";
  };

  config = {
    environment.systemPackages = (if cfg.arion then [
      pkgs.arion
    ] else [ ]) ++
    (if cfg.vagrant then [
      pkgs.vagrant
    ] else [ ]);

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
        rootless = {
          enable = cfg.docker-rootless;
        };
        liveRestore = false;
      };
      podman = {
        enable = cfg.podman;
        defaultNetwork = {
          dnsname = {
            enable = cfg.podman;
          };
        };
      };

      waydroid = {
        enable = cfg.waydroid;
      };
    };

    users.extraGroups.vboxusers.members = cfg.virtualboxUsers;

  };
}
