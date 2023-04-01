{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.gpg;
in
{
  options.jenkos.services.gpg = with types; {
    enable =
      mkBoolOpt false "enable gpg?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qrencode
      paperkey
    ];
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
