{ pkgs, ... }:
let
  chromium = "${pkgs.chromium}/bin/chromium --new-window";
in
pkgs.writeShellScriptBin "workchat" ''

  ${chromium} --new-window https://teams.microsoft.com & 
  ${chromium} --new-window https://app.gather.town/app/QoCbQIsjRXhTgKsa/ship-it-lane &
  
''

