{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.users.jenkin;
in
{
  options.jenkos.users.jenkin = with types; {
    enable = mkBoolOpt false "enable jenkin user?";
    extraGroups = mkOpt (listOf str) [ ] "add extra groups to jenkin?";
  };

  config = mkIf cfg.enable {
    users.users.jenkin = {
      isNormalUser = true;
      description = "Jenkin Schibel";
      extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "docker" "podman" "jackaudio" ] ++ cfg.extraGroups;
      shell = pkgs.zsh;
      initialPassword = "";
    };

  };
}

