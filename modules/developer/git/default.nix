{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.git;
in
{
  options.jenkos.developer.git = with types; {
    enable = mkBoolOpt false "enable all git tools?";
    github = mkBoolOpt false "enable github tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      delta
      git-annex
      git-town
      lazygit
      meld
    ] ++ optParams cfg.github [ gh ] [ ];

  };
}
