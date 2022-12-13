# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  initialPassword = "";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "skyberspace"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
   allowedUDPPorts = [ 3000 19240 ];
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

  services.trezord.enable = true;

  #virtualisation stuff
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  users.extraGroups.vboxusers.members = ["jenkin"];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;


  # Enable the Cinnamon Desktop Environment.
  # services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  hardware.bluetooth.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
    };
  };

  users.users.root.initialHashedPassword = initialPassword;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenkin = {
    isNormalUser = true;
    description = "jenkin Schibel";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" ];
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
      firefox
      chromium
      brave
      tor
      tor-browser-bundle-bin

      git
      vim
      neovim

      python3

      kitty
      xterm

      tldr
      wget
      curl
      pass
      polybarFull
      file
      xclip
      flameshot
      magic-wormhole

      libreoffice
      spotify
      tdesktop
      obs-studio
      blender
      openscad
      mpv
      feh
      redshift
      brightnessctl
      pulsemixer
      pulseaudio-ctl
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
      lazygit
      delta
      ripgrep
      fd
      entr
      unclutter
      steam-run
      autorandr

      newsboat

      rnix-lsp

      nodejs-16_x

      monero-cli
      monero-gui
      trezor-suite

      bluez
      blueman
      bluez-tools

      udiskie
      ntfs3g
      (steam.override { withJava = true; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.slock.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.adb.enable = true;
  

  programs.java.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
