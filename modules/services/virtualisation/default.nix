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
    qemu = mkBoolOpt false "enable qemu";
    virtualbox = mkBoolOpt false "enable virtualbox";
    vagrant = mkBoolOpt false "enable vagrant";
    virtualboxUsers = mkOpt (listOf str) [ ] "users to be added to virtualbox";
  };

  config = {

    environment.systemPackages = optList cfg.arion [ pkgs.arion ] ++ optList [ pkgs.vagrant ] ++ cfg.qemu [ qemu_full qemu-utils ];

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

    users.extraGroups.vboxusers.members = cfg.virtualboxUsers;

  };
}
