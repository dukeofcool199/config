{ pkgs, ... }:

with pkgs;
let
  version = "2.0.14";
  ugs = fetchTarball
    {
      url = "https://github.com/winder/Universal-G-Code-Sender/releases/download/v${version}/ugs-platform-app-${version}.zip";
      sha256 = "sha256:0124rjad1a0va8a6hj4nl5618499mkirn4qh3g4r1jn2bgimxymx";
    };
in

writeShellApplication
{
  name = "universalGcodeSender";
  runtimeInputs = [ ugs jre8 ];
  text = ''
    ${ugs}/bin/ugsplatform
  '';

}


