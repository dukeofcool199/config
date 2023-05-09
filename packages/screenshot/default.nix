{ pkgs, ... }:
with pkgs;
pkgs.writeShellScriptBin "screenshot" ''

  ${pkgs.flameshot}/bin/flameshot gui
  
  
''

