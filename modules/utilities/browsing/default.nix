{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.browsing;
in
{
  options.jenkos.utilities.browsing = with types; {
    graphical =
      mkBoolOpt false "enable all my favorite graphical browsers?";
    cli = mkBoolOpt false "enable all my favorite terminal browsers?";
    tor = mkBoolOpt false "enable tor browsers?";
  };

  config = {
    environment.systemPackages = with pkgs;
      optParams cfg.graphical [ firefox chromium brave qutebrowser ] [ ] ++
      optParams cfg.cli [ browsh lynx ] [ ] ++
      optParams cfg.tor [ tor tor-browser-bundle-bin ] [ ]
    ;
  };
}
