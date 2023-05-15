{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.shelltools;
in
{
  options.jenkos.utilities.shelltools = with types; {
    enable = mkBoolOpt false "enable jenkins favorite shell tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
      up
      glow
      tldr
      file
      fd
      asciiquarium
      zip
      unzip
      exa
      fzf
      ripgrep
      entr
      steam-run
      xclip
    ];

  };
}
