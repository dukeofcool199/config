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
    desktop = {
      xorg = {
        basicConfigs = yes;
        windowManager = {
          xmonad = enabled;
        };
        utilities = enabled;
      };
    };
    networking = {
      enable = yes;
      allowedTcpPorts = [ 8081 8082 8080 5000 5173 5174 7946 2377 ];
      allowedUdpPorts = [ 7946 4789 2377 ];
    };
    autorandr = {
      enable = yes;
      jenkinDesk = enabled;
    };
    services = {
      virtualisation = {
        docker = yes;
        docker-rootless = yes;
        vmware = yes;

        qemu = yes;

        virtualbox = yes;
        virtualboxUsers = [ "jenkin" ];

        vagrant = yes;
        wine = yes;
      };
      ssh = {
        openssh = enabled;
      };
      sftp = {
        enable = yes;
        users = [ "jenkin" ];
      };
      printing = enabled;
      avahi = enabled;
      gpg = enabled;
      udisks = enabled;
      pass = enabled;
      kdeconnect = enabled;
    };
    hardware = {
      zsa = enabled;
      audio = enabled;
      bluetooth = enabled;
    };
    apps = {
      ardour = enabled;
      obs = enabled;
    };
    gaming = {
      steam = enabled;
    };
    developer = {
      git = {
        enable = yes;
        github = yes;
      };
      embedded = {
        car = enabled;
      };
      vim = enabled;
      python = enabled;
      nodejs = enabled;
      haskell = enabled;
      nix = enabled;
      training = enabled;
      android = enabled;
      java = enabled;
      vscode = enabled;
      # remoteBuilders = enabled;
    };
    users = {
      jenkin = enabled;
    };
    utilities = {
      organization = enabled;
      crypto = enabled;
      networking = enabled;
      office = enabled;
      browsing = {
        graphical = yes;
        cli = yes;
        tor = yes;
      };
      audio = {
        cli = yes;
        tui = yes;
      };
      filemanager = {
        gui = yes;
        tui = yes;
      };
      art = enabled;
      shelltools = enabled;
      media = enabled;
      chat = enabled;
      sysadmin = enabled;
      email = enabled;
      filecopy = enabled;
      threeDprinting = enabled;
      threeDModeling = enabled;
      pdf = enabled;
      screenshot = enabled;
      slock = enabled;
    };
  };

  # //TODO: fix this so email is in email module probably with an overlay
  nix.settings.trusted-users = [ "jenkin" ];

  environment.systemPackages = with pkgs;
    [
      email
      dotgit
      gnomecast
      chatgpt-cli
      pop
      todo
      mods
      nodePackages.mermaid-cli
      mermaid
      fjira
      polycide
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

