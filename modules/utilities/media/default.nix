{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.media;
in
{
  options.jenkos.utilities.media = with types; {
    enable = mkBoolOpt false "enable all my favorite media utilities?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        spotify
        mpv
        feh
        ffmpeg
        youtube-dl
        vlc
      ];
  };
}
