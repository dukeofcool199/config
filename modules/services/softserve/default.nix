{ config, lib, ... }:

with lib;
let
  cfg = config.jenkos.services.softserve;
in
{
  options.jenkos.services.softserve = with types; {
    enable =
      mkBoolOpt false "enable softserve?";
  };

  config = mkIf cfg.enable {
    systemd.services.softserve = {

      enable = true;
      after = [ "network.target" ];
      serviceConfig = {

        ExecStart = "${pkgs.soft-serve}/bin/soft serve";
        PrivateTmp = "yes";
        User = "root";
      };

    };
  };
}
