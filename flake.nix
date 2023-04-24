{
  description = "My NixOS / nix-darwin / nixos-generators systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-generators.url =
      "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    tunerstudio = {
      url = "https://www.tunerstudio.com/downloads2/TunerStudioMS_v3.1.08.tar.gz";
      flake = false;
    };


    snowFallFlake.url = "github:snowfallorg/flake";
    snowFallFlake.inputs.nixpkgs.follows = "unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      configuration =
        inputs.snowfall-lib.mkFlake {

          package-namespace = "jenkos";

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

      devShells = inputs.flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = inputs.nixpkgs.legacyPackages.${system};
            bugs = pkgs.writeShellScriptBin "bugs" ''
              ${pkgs.git-bug}/bin/git-bug termui
            '';
          in
          with pkgs;
          {
            devShells.default = mkShell
              {
                buildInputs = [ inputs.snowFallFlake.packages.${system}.default git-bug git-appraise bugs ];
                # shellHook = ''git bug pull && git bug push'';
              };
          });
    in
    inputs.nixpkgs.lib.recursiveUpdate configuration devShells;
}
