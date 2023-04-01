{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.slock;
in
{
  options.jenkos.utilities.slock = with types; {
    enable = mkBoolOpt false "enable slock?";

  };
  config = mkIf cfg.enable {
    programs.slock.enable = true;

  };
}
