{ pkgs, lib, ... }:

let

twilight-commander = pkgs.rustPlatform.buildRustPackage rec {

  pname = "twilight-commander";
  version = "0.14.1";

  src = pkgs.fetchFromGitHub {
    owner = "golmman";
    repo = pname;
    rev = version;
    sha256 = "sha256-BDWp+4SBm7pB8Tu0tlWEq6W9Tvw5VMeBzYDm5ODQt9c=";
  };

  cargoBuildFlags = "--release";
  cargoSha256 = "sha256-zJLHufeNeqUXlhDxDL5xEuTDBufjz7W4Jq+qs4Z8dc8=";

  meta = with lib; {
    description = "A simple console tree file explorer for linux.";
    homepage = "https://github.com/golmman/twilight-commander";
    license = licenses.mit;
    maintainers = [ ];
  };
};


in {
  environment.systemPackages = with pkgs; [
    twilight-commander
  ];
}