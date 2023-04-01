{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.apps.obs;
in
{
  options.jenkos.apps.obs = with types; {
    enable = mkBoolOpt false "enable obs with custom settings?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          obs-vkcapture
          obs-pipewire-audio-capture
          obs-backgroundremoval
          obs-gstreamer
          obs-multi-rtmp
          looking-glass-obs
          input-overlay
        ];
      })
    ];
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    jenkos.hardware.audio = enabled;
  };
}
