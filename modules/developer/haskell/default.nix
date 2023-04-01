{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.haskell;
in
{
  options.jenkos.developer.haskell = with types; {
    enable = mkBoolOpt false "install haskell tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ghc
      cabal-install
      stack
    ];
  };
}
