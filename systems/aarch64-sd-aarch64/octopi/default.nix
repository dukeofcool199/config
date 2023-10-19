{ pkgs, config, lib, modulesPath, inputs, ... }:


with lib;
{
  imports = with inputs.nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.crossSystem.system = "aarch64-linux";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi3;
  };

  jenkos = {
    services = {
      octoprint = enabled;
      ssh = {
        openssh = enabled;
      };
      udisks = enabled;
    };
    developer = {
      git = enabled;
      vim = enabled;
      nix = enabled;
    };
    users = {
      jenkin = enabled;
    };
    utilities = {
      networking = enabled;
      filemanager = {
        tui = yes;
      };
      shelltools = enabled;
      sysadmin = enabled;
      filecopy = enabled;
    };
    system = {
      nix = enabled;
      boot = {
        enable = mkForce false;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
