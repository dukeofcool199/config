{ pkgs, ... }:
with pkgs;
let
  game = pkgs.stdenv.mkDerivation {
    name = "Polycide.exe";
    src = requireFile {
      name = "polycide-folder.zip";
      sha256 = "sha256-VspNEQ8xXy4t+65heVKtJ0ccA0QR8WH/J9YGvPkdQh4=";
      url = "https://jenkin199.itch.io/polycide3";
    };
    buildInputs = [ pkgs.unzip ];
    buildPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir $out
      cp -r polycide\ folder/* $out
    '';

  };
in

writeShellApplication {
  name = "polycide";
  runtimeInputs = [ wine wine64 winetricks game ];
  text = ''
    wine ${game}/${game.name} -v

  '';


}  
