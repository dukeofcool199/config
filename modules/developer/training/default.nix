{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.training;
in
{
  options.jenkos.developer.training = with types; {
    enable = mkBoolOpt false "install developer training tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      exercism
    ];
  };
}
