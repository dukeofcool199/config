{ buildGoModule, fetchFromGitHub, ... }:

buildGoModule rec {
  pname = "mods";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-0PykG19DAVVziRAefQ0LENMuTfTJSVFvs0bMJXdDkrE=";
  };

  vendorSha256 = "sha256-DfIXW5cfTnXPgl9IC5+wTFJ04qWX4RlVoDIYM5gooks=";


}
