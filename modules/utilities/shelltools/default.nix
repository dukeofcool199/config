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
      cool-retro-term
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
      bat
      fzf
      ripgrep
      entr
      xclip
      so
      broot
      trashy
    ];

  };
}
