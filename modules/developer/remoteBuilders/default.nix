{ options, config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.jenkos.developer.remoteBuilders;
in
{
  options.jenkos.developer.remoteBuilders = with types; {
    enable = mkBoolOpt false "enable nix remote builders?";
  };

  config = mkIf cfg.enable {
    nix = {
      buildMachines = [{
        hostName = "browndog";
        systems = [ "x86_64-linux" "aarch64-linux" ];
        maxJobs = 4;
        supportedFeatures = [ "big-parallel" "nixos-test" "benchmark" "kvm" ];
      }];


      distributedBuilds = true;
      extraOptions = ''
        builders-use-substitutes = true
      '';

    };
  };
}
