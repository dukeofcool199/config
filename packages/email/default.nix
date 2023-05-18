{ pkgs, ... }:
with pkgs;
writeShellApplication {
  name = "email";
  runtimeInputs = [ brave gum ];
  text = ''
    jenkin="jenkin.schibel@proton.me" 
    jenkinUrl="https://mail.proton.me/u/2/inbox"
    shared="halkin.schibel@proton.me"
    sharedUrl="https://mail.proton.me/u/1/inbox"
    tty -s;

    if [ "1" == "$?" ]; then 
      brave --new-window "$jenkinUrl"
    else
      choice=$(gum choose "$jenkin" "$shared")

      echo "$choice"

      if [ "$choice" == "$jenkin" ]
      then 
        brave --new-window $jenkinUrl
      elif [ "$choice" == "$shared" ]
      then
        brave --new-window "$sharedUrl"
      else
        echo "not a valid choice"
      fi
    fi
  '';


}  
