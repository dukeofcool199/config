{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.pass;
in
{
  options.jenkos.services.pass = with types; {
    enable = mkBoolOpt false "enable pass?";
    gui = mkBoolOpt false "enable gui for pass?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pass
      qrencode
      dmenu
      git
    ] ++ optList cfg.gui [ qtpass ];
  };
}
