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
      <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    ];
  virtualisation = {
    memorySize = 7629; # Use 2048MiB memory.
    cores = 4;         # Simulate 4 cores.
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelModules = [ "kvm-intel" ];

  networking.hostName = "skyberspace"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowPing = false;
  };


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
    initialHashedPassword = initialPassword;
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

 
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
      firefox
      qutebrowser
      chromium
      brave
      librewolf
      tor
      tor-browser-bundle-bin

      docker
      git
      vim
      neovim
      virtualbox

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
      obs-studio
      blender
      openscad
      mpv
      feh
      redshift
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
      ripgrep-all
      entr
      unclutter
      steam-run
      autorandr

      newsboat

      rnix-lsp

      nodejs-16_x

      monero-cli
      monero-gui

      bluez
      blueman
      bluez-tools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
    programs.zsh.ohMyZsh = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
