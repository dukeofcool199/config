{ pkgs, ... }:
with pkgs;
writeShellApplication {
  name = "mermaid";
  runtimeInputs = [ surf ];
  text = ''
    surf https://mermaid.live
  '';


}  
