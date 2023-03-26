{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.ssh.openssh;
in
{
  options.jenkos.services.ssh.openssh = with types; {
    enable =
      mkBoolOpt false "enable openssh?";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
    };
  };
}
