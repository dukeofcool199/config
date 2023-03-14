# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, inputs, ... }:


let
  inherit (inputs) nixos-hardware;
in
{


  imports = with nixos-hardware.nixosModules;
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      system76
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ ];

    };
    kernelModules = [ "kvm-intel" "v4l2loopback" "snd-aloop" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 42;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';

  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/c5266a7f-324b-479c-92d9-cea3bc9cf765";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/7F66-8253";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/4dd70220-2af8-4d5f-a04f-6e1fb849d86c"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
