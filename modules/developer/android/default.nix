{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.android;
in
{
  options.jenkos.developer.android = with types; {
    enable = mkBoolOpt false "enable android development support?";
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
    programs.java.enable = true;

    environment.systemPackages = with pkgs; [
      android-tools
      android-udev-rules
    ];
  };
}
