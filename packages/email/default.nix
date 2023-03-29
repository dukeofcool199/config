{ pkgs, ... }:
let
  brave = "${pkgs.brave}/bin/brave --new-window";
  gum = "${pkgs.gum}/bin/gum";
in
pkgs.writeShellScriptBin "email" ''
  jenkin="jenkin.schibel@proton.me" 
  jenkinUrl="https://mail.proton.me/u/2/inbox"
  shared="halkin.schibel@proton.me"
  sharedUrl="https://mail.proton.me/u/1/inbox"
  tty -s;

  if [ "1" == "$?" ]; then 
    ${brave} $jenkinUrl
  else
    choice=$(${gum} choose $jenkin $shared)

    echo $choice

    if [ $choice == $jenkin ]
    then 
      ${brave} $jenkinUrl
    elif [ $choice == $shared ]
    then
      ${brave} $sharedUrl
    else
      echo "not a valid choice"
    fi
  fi
''

