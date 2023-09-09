# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib;
{
  imports =
    [
      ./hardware.nix
    ];

  jenkos = {
    system = {
      nix = enabled;
      time = enabled;
      localisation = enabled;
      environment = enabled;
      boot = enabled;
    };
    networking = enabled;
    services = {
      ssh = {
        openssh = enabled;
      };
      printing = enabled;
      avahi = enabled;
      udisks = enabled;
      xserver = enabled;
      pass = {
        enable = true;
        gui = true;
      };

      sftp = {
        enable = yes;
        users = [ "halley" ];
      };
      gpg = enabled;
    };

    developer = {
      git = {
        enable = yes;
      };
      vim = enabled;
      nix = enabled;
      vscode = enabled;
      python = enabled;
    };
    hardware = {
      zsa = enabled;
      audio = enabled;
      bluetooth = enabled;
    };
    utilities = {
      browsing = {
        graphical = yes;
        tor = yes;
      };
      threeDModeling = enabled;
      office = enabled;
      chat = enabled;
      art = enabled;
      shelltools = enabled;
      screenshot = enabled;
      filecopy = enabled;
    };
    users = {
      halley = enabled;
      jenkin = enabled;
    };
  };

  services.xserver.desktopManager.plasma5.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    todo
    qgis
  ];

  _module.args.nixinate = {
    host = "192.168.1.41";
    sshUser = "root";
    buildOn = "local";
    substituteOnTarget = true;
    hermetic = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
