{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.softserve;
in
{
  options.jenkos.services.softserve = with types; {
    enable = mkBoolOpt false "enable softserve?";
    dataDir = mkOpt types.str "/var/lib/soft-serve" "set the data directory";
    user = mkOpt types.str "softserve" "set the user";
    group = mkOpt types.str "softserve" "set the group";
  };

  config = mkIf cfg.enable {

    users.users.${cfg.user} =
      if cfg.user == "softserve" then {
        isSystemUser = true;
        group = cfg.group;
        home = cfg.dataDir;
        createHome = true;
      } else { };

    users.groups.${cfg.group} = { };

    systemd.services.softserve = {
      enable = true;
      after = [ "network.target" ];
      serviceConfig = {

        ExecStart = "${pkgs.soft-serve}/bin/soft serve";
        PrivateTmp = "yes";
        User = "root";
      };
      preStart = ''
        mkdir -p ${cfg.dataDir}
        chown -R root ${cfg.dataDir}
      '';

    };
  };
}
