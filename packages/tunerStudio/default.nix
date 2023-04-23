{ pkgs, tunerstudio, ... }:


with pkgs;
stdenv.mkDerivation rec {
  name = "tuner-studio";
  pname = "TunerStudio";
  version = "3.1.08";
  src = tunerstudio;
  buildInputs = [ sd jdk ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    sd 'java' '${jdk}/bin/java' $out/bin/TunerStudio.sh
    mv $out/bin/TunerStudio.sh $out/bin/${pname}
    chmod 777 $out/bin/${pname}
  '';

}

