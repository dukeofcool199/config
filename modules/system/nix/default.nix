{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.system.nix;
in
{
  options.jenkos.system.nix = with types; {
    enable = mkBoolOpt false "enable my standard nix specific configurations?";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" "impure-derivations" "ca-derivations" ];
      trusted-users = [ "@wheel" "jenkin" "root" ];
      sandbox = "relaxed";
    };
  };
}
