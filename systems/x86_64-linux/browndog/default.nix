{ config, pkgs, inputs, lib, ... }:
with lib;
{
  imports = [ ./hardware.nix ];

  jenkos = {
    system = {
      nix = enabled;
      time = enabled;
      localisation = enabled;
      environment = enabled;
      boot = enabled;
    };
    networking = {
      enable = yes;
      allowedTcpPorts = [ 80 443 ];
    };
    services = {
      virtualisation = {
        docker = yes;
        docker-rootless = yes;
        arion = yes;
      };
      ssh = {
        openssh = {
          enable = yes;
          permitRootLogin = yes;
        };
      };
      sftp = {
        enable = yes;
        users = [ "jenkin" ];
      };
      printing = enabled;
      avahi = enabled;
      gpg = enabled;
      udisks = enabled;
    };
    developer = {
      git = {
        enable = yes;
        github = yes;
      };
      vim = enabled;
      nix = enabled;
    };
    users = {
      jenkin = enabled;
      git-annex = enabled;
    };
    utilities = {
      networking = enabled;
      browsing = {
        cli = yes;
      };
      filemanager = {
        tui = yes;
      };
      shelltools = enabled;
      sysadmin = enabled;
      filecopy = enabled;
    };
  };

  _module.args.nixinate = {
    host = "192.168.1.103";
    sshUser = "root";
    buildOn = "remote";
    substituteOnTarget = true;
    hermetic = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

