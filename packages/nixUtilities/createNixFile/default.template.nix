{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkDerivation {

  name = "executable name";
  pname = "derivation name";

  src = ./.;

  buildInputs = [ ];

  buildPhase = '''';

  installPhase = '''';

}

