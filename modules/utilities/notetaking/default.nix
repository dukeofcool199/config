{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.notetaking;
  nbTools = with pkgs;[ nodePackages.readability-cli nb w3m nmap pandoc ripgrep tig w3m ];
in
{
  options.jenkos.utilities.notetaking = with types; {
    enable =
      mkBoolOpt false "enable all my favorite note taking tools?";
  };

  config = mkIf cfg.enable {
    programs = {
      mtr = { enable = yes; };
    };
    environment.systemPackages = with pkgs; [ ] ++ nbTools;

  };
}
