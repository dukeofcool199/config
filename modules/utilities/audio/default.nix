{ options, config, lib, pkgs, ... }:

with lib;
with pkgs;
let
  cfg = config.jenkos.utilities.audio;
in
{
  options.jenkos.utilities.audio = with types; {
    cli = mkBoolOpt false "enable all my favorite cli audio management tools?";
    tui = mkBoolOpt false "enable all my favorite tui audio management tools?";
    gui = mkBoolOpt false "enable all my favorite gui audio management tools?";
  };

  config = {
    environment.systemPackages = with pkgs; optList cfg.cli [ pulseaudio-ctl ] ++ optList cfg.tui [ pulsemixer ] ++ optList cfg.gui [ pavucontrol ];

  };
}
