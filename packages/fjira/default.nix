{ lib, buildGoModule, fetchgit, ... }:

buildGoModule rec {
  name = "fjira";
  pname = "${name}-cli";
  version = "0.11.0";

  src = fetchgit {
    url = "https://github.com/mk-5/${name}";
    rev = "${version}";
    sha256 = "sha256-YITxH/IzGxngjYeJkuFxJ25hQVm6x04nlUziGvx00rU=";
  };

  doCheck = false;

  vendorHash = "sha256-D2cMrVDYPKIS+jbpJM2epPrTBb6zinfO6Yvp/ixk0FM=";

}
