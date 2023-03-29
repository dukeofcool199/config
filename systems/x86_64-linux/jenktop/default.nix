# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

with lib;
let

  initialPassword = "";
in
{
  imports =
    [
      ./hardware.nix
    ];


  jenkos = {
    desktop = {
      windowManager = {
        xmonad = enabled;
      };
    };
    networking = {
      enable = true;
      isFtpServer = true;
    };
    autorandr = {
      jenkinDesk = enabled;
    };
    services = {
      virtualisation = {
        docker = enable;
        vmware = enable;
        virtualbox = enable;
        arion = enable;
        vagrant = enable;
      };
      ssh = {
        openssh = enabled;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  # Enable the X11 windowing system.

  services.udisks2.enable = true;


  services.udev.packages = with pkgs;
    [ zsa-udev-rules ];

  services.trezord.enable = true;

  services.pcscd.enable = true;

  services.flatpak.enable = true;

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
    userlist = [ "jenkin" ];
    userlistEnable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  users.extraGroups.vboxusers.members = [ "jenkin" ];

  # Enable the Cinnamon Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
      };
    };
  };



  # Configure keymap in X11

  # Enable CUPS to print documents.
  services.printing =
    {
      enable = true;
      stateless = true;
      startWhenNeeded = true;
    };
  services.system-config-printer.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
  };

  hardware.bluetooth.enable = false;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  users.users.root.initialHashedPassword = initialPassword;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenkin = {
    isNormalUser = true;
    description = "jenkin Schibel";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "docker" "podman" "jackaudio" "wireshark" ];
    shell = pkgs.zsh;
    initialHashedPassword = initialPassword;
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "openjdk-18+36"
      ];
      packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs;
            [
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
    qutebrowser
    tor
    tor-browser-bundle-bin

    git
    gh
    git-annex
    git-town
    vim
    glow
    neovim
    sysz
    inputs.snowFallFlake.packages.x86_64-linux.default
    httpie

    up

    scrcpy

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
    gthumb
    gimp
    slic3r
    clamav
    freecad
    spotify
    tdesktop
    blender
    openscad
    mpv
    feh
    okular
    gnome.simple-scan
    mupdf
    redshift
    brightnessctl
    pulsemixer
    pulseaudio-ctl
    xbindkeys
    xbindkeys-config
    zip
    unzip
    asciiquarium
    qrencode

    qemu_full
    qemu-utils
    qtemu


    jabref
    ardour
    lsp-plugins
    distrho
    tap-plugins
    noise-repellent
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [ obs-pipewire-audio-capture ];
    })

    direnv
    nix-direnv
    arion

    dmenu
    bottom
    htop
    ncdu
    rofi
    exa
    fzf
    lazygit
    delta
    ripgrep
    fd
    ranger
    rox-filer
    entr
    unclutter
    autorandr
    arandr

    nil
    niv
    rnix-lsp
    nixpkgs-fmt
    nix-doc

    nodejs-16_x

    #haskell
    ghc
    cabal-install
    stack

    monero-cli
    monero-gui
    trezor-suite
    exodus

    #communication
    zoom-us
    discord
    element-desktop
    weechat

    bluez
    blueman
    bluez-tools

    pcsclite
    pcsctools

    udiskie
    ntfs3g

    #email
    alot
    notmuch
    offlineimap
    protonmail-bridge


    #games
    tuxtype
    tuxpaint
    superTux
    superTuxKart
    exercism
    minecraft
    steam-run
    (steam.override {
      withJava = true;
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.slock.enable = true;

  programs.kdeconnect.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.adb.enable = true;


  programs.java.enable = true;

  # nix options for derivations to persist garbage collection
  nix.settings = {
    keep-outputs = false;
    keep-derivations = false;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "jenkin" ];
  };
  nix.extraOptions = ''
    plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
  '';

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  environment.variables = {
    XCURSOR_SIZE = "40";
    LV2_PATH = "/run/current-system/sw/lib/lv2/";
  };

  # if you also want support for flakes
  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

