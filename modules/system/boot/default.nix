{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.jenkos.system.boot;
in
{
  options.jenkos.system.boot = with types; {
    enable = mkBoolOpt false "common boot options?";
    grub = mkBoolOpt false "grub?";
    efi = mkBoolOpt true "booted with efi?";
  };

  config = mkIf cfg.enable {
    boot = {
      loader =
        if cfg.grub then {
          efi =
            if cfg.efi then {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot/efi";
            } else { };
          grub = {
            efiSupport = true;
            efiInstallAsRemovable = false;
            device = "nodev";
          };
        } else {
          systemd-boot.enable = true;
          systemd-boot.configurationLimit = 35;
          efi.canTouchEfiVariables = cfg.efi;
          efi.efiSysMountPoint = if cfg.efi then "/boot/efi" else "/boot";

          # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
          systemd-boot.editor = false;

        };
    };



  };
}

