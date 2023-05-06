{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.hardware.nvidia;
in
{

  options.jenkos.hardware.nvidia = with types;
    {
      enable = mkBoolOpt false "enable nvidia hardware support?";
    };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      nvidia = {
        forceFullCompositionPipeline = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        open = true;
      };
      opengl.enable = true;
    };


  };
}
