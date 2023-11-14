{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.hardware.bluetooth;
in
{
  options.jenkos.hardware.bluetooth = with types; {
    enable =
      mkBoolOpt false "enable bluetooth?";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    environment.systemPackages = with pkgs; [
      bluez
      blueman
      bluez-tools
    ];
  };

}
