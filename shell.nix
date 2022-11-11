{ pkgs ? import <nixpkgs> {},nixos ? import <nixos> {}  }:

pkgs.mkShell {
  buildInputs = [
    pkgs.neo-cowsay
    nixos.nixos-build-tools
  ];

  shellHook = ''
    echo "Nix configs" | cowsay --aurora
  '';
}
