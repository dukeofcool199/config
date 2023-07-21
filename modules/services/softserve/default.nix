{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.services.softserve;
in
{
  options.jenkos.services.softserve = with types; {
    enable = mkBoolOpt false "enable softserve?";
    user = mkOpt types.str "softserve" lib.mdDoc ''the user softserve should run as'';
    directory = mkOpt types.str "/var/lib/soft-serve" lib.mdDoc ''the location of the data directory'';
  };

  config = mkIf cfg.enable {
    systemd.services.softserve = {

      environment = {
        SOFT_SERVE_DATA_PATH = cfg.directory;
      };
      enable = true;
      serviceConfig = {
        ExecStart = "${pkgs.soft-serve}/bin/soft serve";
        PrivateTmp = "yes";
        User = cfg.user;
      };

    };
  };
}
