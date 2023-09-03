{ blender-bin, ... }:

final: prev:
{
  blender = blender-bin.packages.${final.system}.default;
}
