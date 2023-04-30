{ pkgs, lib, ... }:


with pkgs;
with python3.pkgs;
buildPythonPackage rec {
  name = "dotgit";
  pname = name;
  version = "2.2.9";
  src = fetchPypi {
    pname = "dotgit";
    version = version;
    hash = "sha256-5QTDVXANJH8W8xR3ZG8xswQwuaHYCfTQcn21GkRMrEE=";
  };

}

