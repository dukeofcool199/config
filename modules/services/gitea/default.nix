{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.gitea;
in
{
  options.jenkos.services.gitea = with types; {
    enable =
      mkBoolOpt false "enable gitea?";
  };

  config = mkIf cfg.enable {
    services.gitea = {
      enabled = yes;
      dump = {
        enable = yes;
      };
    };
  };
}
