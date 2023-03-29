{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.autorandr;
in
{
  options.jenkos.autorandr = with types; {
    enable = mkBoolOpt no "enable autorandr?";
  };

  config = mkIf cfg.enable {
    services.autorandr = {
      enable = yes;
    };
  };
}
