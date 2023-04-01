{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.jenkos.system.localisation;
in
{
  options.jenkos.system.localisation = with types; {
    enable = mkBoolOpt false "enable localisation information?";
    locale = mkStrOpt "en_US.utf8" "what locale?";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = cfg.locale;
  };
}

