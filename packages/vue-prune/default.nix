{ buildNpmPackage, fetchFromGitHub, ... }:

buildNpmPackage
rec {
  name = "check-unused-comp";
  src = fetchFromGitHub
    {
      owner = "BerniWittmann";
      repo = "vue-unused-components-checker";
      rev = "8f7ca93c28cfbd9269dba2254d4a4fcbc72cd75f";
      hash = "sha256-Jd2QdDJXkqwY+cStjNEj6N1Zx8UVpnc5uZBfi/MkDdM=";
    };
  npmDepsHash = "sha256-RD0EePhYM0I9akgnzLRWYuRP6c3ZTYBO5mK6foPp8Qw=";

}
