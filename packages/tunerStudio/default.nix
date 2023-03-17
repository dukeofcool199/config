{ pkgs, ... }:


with pkgs;
stdenv.mkDerivation {
  name = "TunerStudio.sh";
  pname = "tuner-studio";
  version = "3.1.08";
  src = fetchTarball
    {
      url = "https://www.tunerstudio.com/downloads2/TunerStudioMS_v3.1.08.tar.gz";
      sha256 = "13pin0fm8bsa35iba0pkl1x2bndwsgfp41pyyhs7xaaky6p865zs";
    };
  buildInputs = [ jdk ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    chmod 777 $out/bin/TunerStudio.sh
  '';

}

