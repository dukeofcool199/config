{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.jenkos.system.environment;
in
{
  options.jenkos.system.environment = with types; {
    enable = mkBoolOpt false "enable basic environment configurations?";
  };

  config = mkIf cfg.enable {
    environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}

