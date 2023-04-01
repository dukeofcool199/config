{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.python;
in
{
  options.jenkos.developer.python = with types; {
    enable = mkBoolOpt false "enable python?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
    ];
  };
}
