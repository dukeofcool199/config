{
  description = "My NixOS / nix-darwin / nixos-generators systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-generators.url =
      "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    snowFallFlake.url = "github:snowfallorg/flake";
    snowFallFlake.inputs.nixpkgs.follows = "unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      systems.hosts.skyberspace.modules = with inputs; [
        nixos-hardware.nixosModules.system76
      ];


      channels-config = {
        allowUnfree = true;
        allowInsecure = true;
      };

    };
}
