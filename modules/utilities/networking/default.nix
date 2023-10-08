{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.networking;
in
{
  options.jenkos.utilities.networking = with types; {
    enable =
      mkBoolOpt false "enable all my favorite networking tools?";
  };

  config = mkIf cfg.enable {
    programs = {
      mtr = { enable = yes; };
    };
    environment.systemPackages = with pkgs; [
      httpie
      http-prompt
      nmap
      curl
      wget
    ];

  };
}
