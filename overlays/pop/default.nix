{ charmbracelet, ... }:

final: prev:
{
  inherit (charmbracelet.packages.${final.system}) pop;
}
