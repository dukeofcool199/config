{ jenkvim, ... }:

final: prev:
{
  neovim = jenkvim.packages.${final.system}.default;
}
