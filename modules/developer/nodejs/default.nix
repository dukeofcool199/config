{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.nodejs;
in
{
  options.jenkos.developer.nodejs = with types; {
    enable = mkBoolOpt false "enable nodejs and supporting tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nodejs-18_x
      bun
    ];
  };
}
