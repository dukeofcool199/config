{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.pdf;
in
{
  options.jenkos.utilities.pdf = with types; {
    enable = mkBoolOpt false "install my favorite pdf tools?";

  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        okular
        mupdf
        koreader
      ];
  };
}
