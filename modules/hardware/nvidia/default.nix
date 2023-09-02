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
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelParams = [ "module_blacklist=amdgpu" ];

    hardware = {
      nvidia = {
        forceFullCompositionPipeline = true;
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
      };
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };


  };
}
