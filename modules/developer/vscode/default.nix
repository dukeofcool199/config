{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.vscode;
in
{
  options.jenkos.developer.vscode = with types; {
    enable = mkBoolOpt false "enable vscode";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}
