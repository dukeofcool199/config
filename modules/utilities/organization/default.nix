{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.organization;
  nbTools = with pkgs;[ nodePackages.readability-cli nb poppler_utils w3m nmap pandoc ripgrep tig w3m ];
in
{
  options.jenkos.utilities.organization = with types; {
    enable =
      mkBoolOpt false "enable all my favorite note taking tools?";
  };

  config = mkIf cfg.enable {
    programs = {
      mtr = { enable = yes; };
    };
    environment.systemPackages = with pkgs; [ todo ] ++ nbTools;

  };
}
