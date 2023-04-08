# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  initialPassword = "";
in
with lib;
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware.nix
    ];

  jenkos = {
    system = {
      nix = enabled;
      time = enabled;
      localisation = enabled;
      environment = enabled;
    };
    networking = {
      enable = yes;
    };
    services = {
      ssh = {
        openssh = enabled;
      };
    };
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 42;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 21 ];
    enable = true;
    allowPing = false;
  };


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.udisks2.enable = true;

  services.udev.packages = with pkgs;[ zsa-udev-rules ];

  # services.xserver.desktopManager.cinnamon.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
    userlist = [ "halley" ];
    userlistEnable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
    };
  };

  users.users.root.initialHashedPassword = initialPassword;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.halley = {
    isNormalUser = true;
    description = "Halley Schibel";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    initialHashedPassword = initialPassword;
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs; [
            libgdiplus
          ];
        };
      };
    };
  };


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

    libreoffice
    spotify
    mpv
    feh
    redshift
    brightnessctl
    xbindkeys
    xbindkeys-config
    zip
    unzip
    asciiquarium

    direnv
    nix-direnv

    dmenu
    rofi
    exa
    fzf
    autorandr

    udiskie
    ntfs3g
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
