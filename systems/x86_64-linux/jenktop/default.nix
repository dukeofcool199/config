# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let

  initialPassword = "";
  deskMonitorHdmi = "00ffffffffffff0006b32b2701000000091f0103803c2278ae9315ae4e46a1260e5054a5cb0081c081809500a9c0b300d1c001010101565e00a0a0a029503020350055502100001a000000fd0030901ed83c000a202020202020000000ff004d324c4d44573031363938360a000000fc005647323757510a20202020202001d5020349f35301023f0405901113141f60615d5e5f40061522230907078301000068030c002000382d0067d85dc401788003681a000001013090ede305e301e30f000ce60607016659289ee00078a0a032501040350055502100001a6fc200a0a0a055503020350055502100001a5aa000a0a0a046503020350055502100001ae9";
  laptopDisplay = "00ffffffffffff000daed51400000000281a0104a51f117802ee95a3544c99260f505400000001010101010101010101010101010101b43b804a71383440503c680035ad10000018000000fe004e3134304843452d454e320a20000000fe00434d4e0a202020202020202020000000fe004e3134304843452d454e320a200010";
  deskMonitorUsbC = "00ffffffffffff0006b32b2701000000091f0103803c2278ae9315ae4e46a1260e5054a5cb0081c081809500a9c0b300d1c001010101565e00a0a0a029503020350055502100001a000000fd0030901ed83c000a202020202020000000ff004d324c4d44573031363938360a000000fc005647323757510a20202020202001d5020349f35301023f0405901113141f5e5f5d5e5f40061522230907078301000068030c002000382d0067d85dc401788003681a000001013090ede305e301e30f000ce60607016659289ee00078a0a032501040350055502100001a6fc200a0a0a055503020350055502100001a5aa000a0a0a046503020350055502100001aed";
in
{
  imports =
    [
      ./hardware.nix
    ];



  networking = {
    # Enable networking
    networkmanager.enable = true;

    # Open ports in the firewall.
    firewall = {
      trustedInterfaces = [ "vboxnet0" ];
      enable = true;
      allowPing = false;
      allowedUDPPorts = [ 19240 3000 19241 ];
      allowedTCPPorts = [ 21 ];
    };

  };


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  services.autorandr = {
    enable = true;
    profiles = {
      "dockedHdmi" = {

        fingerprint = {
          HDMI-1 = deskMonitorHdmi;
          eDP-1 = laptopDisplay;
        };
        config = {
          HDMI-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2560x1440";
            rate = "144.00";
          };
          eDP-1 = {
            enable = false;
          };
        };
      };
      "dockedUsbC" = {
        fingerprint = {
          DP-1 = deskMonitorUsbC;
          eDP-1 = laptopDisplay;
        };
        config = {
          DP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2560x1440";
            rate = "59.95";
          };
          eDP-1 = {
            enable = false;
          };
        };
      };
      "laptopOnly" = {
        fingerprint = {
          eDP-1 = laptopDisplay;
        };
        config = {
          eDP-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "60.01";
          };
        };
      };
    };

  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.udisks2.enable = true;

  services.udev.packages = with pkgs;[ zsa-udev-rules ];

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

  #virtualisation stuff
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      guest = {
        enable = true;
        x11 = true;
      };
    };
    docker = {
      enable = true;
    };
    podman = {
      enable = true;
      defaultNetwork = {
        dnsname = {
          enable = true;
        };
      };
    };
  };

  users.extraGroups.vboxusers.members = [ "jenkin" ];





  # Enable the Cinnamon Desktop Environment.
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
    zoom-us
    discord

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