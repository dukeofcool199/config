{ pkgs, ... }:
let
  gum = "${pkgs.gum}/bin/gum";
  shell = ./shell.template.nix;
  default = ./default.template.nix;
in
pkgs.writeShellScriptBin "createNixFile" ''

  choice=$(${gum} choose "default.nix" "shell.nix")

  if [ $choice == "default.nix" ]
  then 
     cat ${default} > ./default.nix
  elif [ $choice == "shell.nix" ]
  then
     cat ${shell} > ./shell.nix
  else
    echo "not a valid choice"
  fi
''


