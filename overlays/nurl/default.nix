{ nurl, ... }:

final: prev:
{
  nurl = nurl.packages.${final.system}.default;
}
