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
    wine = mkBoolOpt false "enable wine";
    qemu = mkBoolOpt false "install qemu tools";
    virtualboxUsers = mkOpt (listOf str) [ ] "users to be added to virtualbox";
  };

  config = {
    environment.systemPackages = with pkgs; (if cfg.arion then [
      arion
    ] else [ ]) ++
    (if cfg.vagrant then [
      vagrant
    ] else [ ]) ++ optList cfg.wine [ wine wine64 winetricks ] ++ optList cfg.podman [ podman podman-compose podman-tui pods ] ++ optList cfg.qemu [ qemu_full qemu-utils virt-manager ];

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
          enable = true;
          setSocketVariable = true;
        };
        liveRestore = false;
      };
      podman = {
        enable = cfg.podman;
        defaultNetwork = {
          settings = {
            dns_enabled = cfg.podman;
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
