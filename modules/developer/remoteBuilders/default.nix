{ options, config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.jenkos.developer.remoteBuilders;
  systems = [ "x86_64-linux" "aarch64-linux" ];
  maxJobs = 4;
  supportedFeatures = [ "big-parallel" "nixos-test" "benchmark" "kvm" ];
in
{
  options.jenkos.developer.remoteBuilders = with types; {
    enable = mkBoolOpt false "setup the remote builders for this machine?";
    distribute = mkBoolOpt false "enable automatic build distribution?";

  };

  config = mkIf cfg.enable {
    nix = {
      buildMachines = [
        {
          hostName = "ammobox";
          inherit systems maxJobs supportedFeatures;
        }
        {
          hostName = "browndog";
          inherit systems maxJobs supportedFeatures;
        }
      ];

      distributedBuilds = cfg.distribute;
      extraOptions = ''
        builders-use-substitutes = true
      '';

    };
  };
}
