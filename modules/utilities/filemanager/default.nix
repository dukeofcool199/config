{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.jenkos.utilities.filemanager;
in
{
  options.jenkos.utilities.filemanager = with types; {
    tui = mkBoolOpt false "enable tui file managers?";
    gui = mkBoolOpt false "enable gui file managers?";

  };
  config = {
    environment.systemPackages = with pkgs;
      optList cfg.tui [ ranger ] ++ optList cfg.gui [ rox-filer ];
  };
}
