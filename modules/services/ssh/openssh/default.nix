{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.ssh.openssh;
in
{
  options.jenkos.services.ssh.openssh = with types; {
    enable =
      mkBoolOpt false "enable openssh?";
    permitRootLogin = mkBoolOpt false "allow root login?";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      permitRootLogin = if cfg.permitRootLogin then "yes" else "prohibit-password";
    };
  };
}
