{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.printing;
in
{
  options.jenkos.services.printing = with types; {
    enable =
      mkBoolOpt false "am I allowed to talk to printers?";
  };

  config = mkIf cfg.enable {
    services = {
      printing = {
        enable = true;
        startWhenNeeded = true;
      };
      system-config-printer.enable = true;
    };
  };
}
