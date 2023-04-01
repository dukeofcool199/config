{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.hardware.audio;
in
{
  options.jenkos.hardware.audio = with types; {
    enable = mkBoolOpt false "enable audio with pipewire?";
  };

  config = mkIf cfg.enable {
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
  };
}
