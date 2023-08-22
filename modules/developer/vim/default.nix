{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.developer.vim;
in
{
  options.jenkos.developer.vim = with types; {
    enable = mkBoolOpt false "enable my vim... well actually neovim?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];
  };
}
