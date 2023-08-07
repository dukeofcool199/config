{ pkgs, ... }:
with pkgs;
writeShellApplication {
  name = "todo";
  runtimeInputs = [ surf ];
  text = ''
    surf https://app.vikunja.cloud/
  '';


}  
