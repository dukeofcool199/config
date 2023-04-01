{ options, config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.jenkos.developer.nix;
in
{
  options.jenkos.developer.nix = with types; {
    enable = mkBoolOpt false "enable nix development tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nil
      alejandra
      nixpkgs-fmt
      nix-doc
      createNixFile
      direnv
      nix-direnv
      inputs.snowFallFlake.packages.x86_64-linux.default
    ];
    environment.pathsToLink = [
      "/share/nix-direnv"
    ];
    nixpkgs.overlays = [
      (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
    ];

  };
}
