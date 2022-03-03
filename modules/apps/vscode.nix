{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.plusultra.apps.vscode;
in {
  options.plusultra.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        # @NOTE(jakehamilton): Code doesn't render properly
        # on Wayland by default. We need to pass two params
        # to make it render correctly.
        (vscode.overrideAttrs (oldAttrs: {
#          buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
#
#          postInstall = oldAttrs.postInstall or "" + ''
#            wrapProgram $out/bin/code \
#              --add-flags "--enable-features=UseOzonePlatform" \
#              --add-flags "--ozone-platform=wayland"
#          '';
        }))
      ];
  };
}
