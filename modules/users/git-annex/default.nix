{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.users.git-annex;
in
{
  options.jenkos.users.git-annex = with types; {
    enable =
      mkBoolOpt false "enable git-annex shared user?";
  };

  config = mkIf cfg.enable {

    users.users.git-annex = {
      isNormalUser = true;
      description = "Git Annex";
      extraGroups = [ ];
      shell = pkgs.zsh;
      initialPassword = "";
    };

  };
}

