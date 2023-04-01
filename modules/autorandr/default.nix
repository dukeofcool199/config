{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.autorandr;
in
{
  options.jenkos.autorandr = with types; {
    enable = mkBoolOpt no "enable autorandr and supporting tools?";
  };

  config = mkIf cfg.enable {
    services.autorandr = {
      enable = yes;
    };

    environment.systemPackages = with pkgs; [
      arandr
    ];

  };
}
