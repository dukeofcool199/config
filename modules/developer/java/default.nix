{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.java;
in
{
  options.jenkos.developer.java = with types; {
    enable = mkBoolOpt false "enable all java support?";
  };

  config = mkIf cfg.enable {
    programs.java.enable = true;

  };
}
