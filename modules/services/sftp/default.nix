{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.sftp;
in
{
  options.jenkos.services.sftp = with types; {
    enable =
      mkBoolOpt false "enable sftp server?";

    users = mkOpt (listOf str) [ ] "the list of users";
  };

  config = mkIf cfg.enable {

    networking = {
      firewall = {
        allowedTCPPorts = [ 21 ];
      };
    };

    services.vsftpd = {
      enable = yes;
      writeEnable = yes;
      localUsers = yes;
      userlist = cfg.users;
      userlistEnable = yes;
    };
  };
}
