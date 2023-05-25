{ pkgs, ... }:
with pkgs;
let
  browser = mupdf;
in
writeShellApplication {
  name = "read";
  runtimeInputs = [ rdrview browser xclip ];
  text = ''

    rdrview  "$(xclip -o -sel clip)" -B ${browser.pname}

  '';


}  
