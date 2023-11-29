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
    programs.zsh.enable = true;
    users.users.jenkin = {
      isNormalUser = true;
      description = "Jenkin Schibel";
      extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "docker" "podman" "jackaudio" "dialout" "libvirtd" ] ++ cfg.extraGroups;
      shell = pkgs.zsh;
      initialPassword = "";
    };

  };
}

