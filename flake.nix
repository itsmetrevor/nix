{


  # TODO: Add nixbook configuration.
  #   - Include lanzeboote for secureboot
  #   - https://github.com/nix-community/lanzaboote


  description = "This flake really ties my systems together";


  inputs = {
    pkgs.url            = "github:nixos/nixpkgs?ref=nixos-unstable";
    pkgs-stable.url     = "github:nixos/nixpkgs?ref=nixos-25.05";

    # NixOS-WSL Docs: https://nix-community.github.io/NixOS-WSL/index.html
    nixos-wsl.url       = "github:nix-community/NixOS-WSL/main";
  };


  outputs = { self, pkgs, pkgs-stable, nixos-wsl, ... }: {

    nixosConfigurations.nixbook = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {};
      modules = [
        ./nixbook/configuration.nix
      ];
    };

    nixosConfigurations.nixwsl = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit pkgs-stable; };
      modules = [
        ./nixwsl/configuration.nix
        nixos-wsl.nixosModules.default 
      ];
    };

    nixosConfigurations.thinknix = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./thinknix/configuration.nix
      ];
    };

  };


}
