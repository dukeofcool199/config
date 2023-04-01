{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.email;
in
{
  options.jenkos.utilities.email = with types; {
    enable = mkBoolOpt false "enable all my favorite file email utilities?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        alot
        email
        notmuch
        offlineimap
        protonmail-bridge
      ];
  };
}
