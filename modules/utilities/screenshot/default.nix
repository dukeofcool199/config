{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.screenshot;
in
{
  options.jenkos.utilities.screenshot = with types; {
    enable = mkBoolOpt false "install my favorite screenshot tools?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [ flameshot screenshot ];
  };
}
