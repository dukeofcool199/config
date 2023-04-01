{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.filecopy;
in
{
  options.jenkos.utilities.filecopy = with types; {
    enable = mkBoolOpt false "enable all my favorite file copy utilities?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        magic-wormhole
        rsync
      ];
  };
}
