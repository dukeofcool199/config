{ channels, ... }:

final: prev: {
  inherit (channels.unstable) prefetch-npm-deps;
}
