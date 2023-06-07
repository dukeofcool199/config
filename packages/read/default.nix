{ pkgs, ... }:
with pkgs;
let
  reader = mupdf;
in
writeShellApplication {
  name = "read";
  runtimeInputs = [ rdrview reader xclip ];
  text = ''

    rdrview  "$(xclip -o -sel clip)" -B ${reader.pname}

  '';


}  
