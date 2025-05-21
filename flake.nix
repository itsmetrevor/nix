{


  description = "This flake really ties my systems together";


  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };


  outputs = { self, nixpkgs, determinate, nixos-wsl, ... }: {

    nixosConfigurations.nixwsl = nixpkgs.lib.nixosSystem {
      # https://nix-community.github.io/NixOS-WSL/how-to/nix-flakes.html
      system = "x86_64-linux";
      modules = [
        ./nixwsl/configuration.nix
        nixos-wsl.nixosModules.default 
        determinate.nixosModules.default
      ];
    };

    nixosConfigurations.thinknix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./thinknix/configuration.nix
        determinate.nixosModules.default
      ];
    };

  };


}
