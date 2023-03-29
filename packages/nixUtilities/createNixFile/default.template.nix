{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkDerivation {

  src = ./.;

  buildInputs = [ ];

  buildPhase = '''';

  installPhase = '''';

}

