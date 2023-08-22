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
      sftp = {
        enable = yes;
        users = [ "halley" ];
      };
      gpg = enabled;
    };
    hardware = {
      zsa = enabled;
      audio = enabled;
      bluetooth = enabled;
    };
    utilities = {
      threeDModeling = enabled;
      office = enabled;
    };
    users = {
      halley = enabled;
      jenkin = enabled;
    };
  };

  services.xserver.desktopManager.plasma5.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    (firefox.override { extraNativeMessagingHosts = [ passff-host ]; })
    chromium

    git
    git-annex
    git-annex-utils
    vim
    pass
    qtpass
    neovim
    vscode

    python3

    tldr
    wget
    curl
    file
    xclip
    flameshot
    magic-wormhole

    mpv
    feh
    zip
    unzip
    asciiquarium

    direnv
    nix-direnv

    exa
    fzf

    qgis
  ];

  _module.args.nixinate = {
    host = "192.168.11.165";
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
