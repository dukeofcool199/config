{ buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mods";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-jOvXT/KAfSN9E4ZgntCbTu05VJu1jhGtv6gEgLStd98=";
  };

  vendorHash = "sha256-GNGX8dyTtzRSUznEV/do1H7GEf6nYf0w+CLCZfkktfg=";

}
