{ config, pkgs, inputs, lib, ... }:

with lib;
{
  imports = [ ./hardware.nix ];

  jenkos = {
    desktop = {
      windowManager = {
        xmonad = enabled;
      };
    };
    networking = {
      enable = yes;
    };
    autorandr = {
      enable = yes;
      jenkinDesk = enabled;
    };
    services = {
      virtualisation = {
        docker = enable;
        vmware = enable;

        virtualbox = enable;
        virtualboxUsers = [ "jenkin" ];

        arion = enable;
        vagrant = enable;
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
    };
    hardware = {
      zsa = enabled;
      audio = enabled;
    };
    utilities = {
      crypto = enabled;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  services.udisks2.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenkin = {
    isNormalUser = true;
    description = "jenkin Schibel";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "docker" "podman" "jackaudio" ];
    shell = pkgs.zsh;
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
    browsh
    brave
    tor
    tor-browser-bundle-bin

    git
    delta
    gh
    git-annex
    git-town
    vim
    glow
    neovim
    inputs.snowFallFlake.packages.x86_64-linux.default
    httpie

    up

    python3

    kitty

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

    dmenu
    htop
    ncdu
    rofi
    exa
    fzf
    lazygit
    ripgrep
    fd
    ranger
    rox-filer
    entr
    unclutter
    arandr

    nil
    alejandra
    nixpkgs-fmt
    nix-doc
    createNixFile

    nodejs-16_x

    #haskell
    ghc
    cabal-install
    stack

    #communication
    zoom-us
    discord
    element-desktop
    workchat
    weechat

    udiskie
    ntfs3g

    #email
    alot
    email
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
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

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

