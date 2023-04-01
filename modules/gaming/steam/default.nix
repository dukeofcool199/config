{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.gaming.steam;
in
{
  options.jenkos.gaming.steam = with types; {
    enable = mkBoolOpt false "enable steam support?";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    programs.steam.remotePlay.openFirewall = true;

    hardware.steam-hardware.enable = true;

    # Enable GameCube controller support.
    services.udev.packages = [ pkgs.dolphinEmu ];

    environment.systemPackages = with pkgs; [
      steam-run
      steam
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
  };
}

