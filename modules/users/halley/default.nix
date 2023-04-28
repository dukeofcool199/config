{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.users.halley;
in
{
  options.jenkos.users.halley = with types; {
    enable =
      mkBoolOpt false "enable halley user?";
    extraGroups = mkOpt (listOf str) [ ] "add extra groups to halley?";
  };

  config = mkIf cfg.enable {

    users.users.halley = {
      isNormalUser = true;
      description = "Halley Schibel";
      extraGroups = [ "wheel" "networkmanager" ] ++ cfg.extraGroups;
      shell = pkgs.zsh;
      initialPassword = "";
    };

  };
}

