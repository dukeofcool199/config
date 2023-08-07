{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.jenkos.system.time;
in
{
  options.jenkos.system.time = with types; {
    enable = mkBoolOpt false "enable timezone information?";
    timezone = mkStrOpt "America/Boise" "what timezone?";
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timezone;
  };
}

