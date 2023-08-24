{ channels, ... }:

final: prev:
{
  inherit (channels.unstable) exodus;
}
