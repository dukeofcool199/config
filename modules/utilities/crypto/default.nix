{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.crypto;
in
{
  options.jenkos.utilities.crypto = with types; {
    enable =
      mkBoolOpt false "enable all my favorite crypto tools?";
  };

  config = mkIf cfg.enable {
    services.trezord.enable = true;

    environment.systemPackages = with pkgs; [
      monero-cli
      monero-gui
      trezor-suite
      # exodus
    ];

  };
}
