{


  description = "This flake really ties my systems together";


  inputs = {
    pkgs-stable.url       = "https://flakehub.com/f/NixOS/nixpkgs/0.*.tar.gz";
    pkgs-unstable.url     = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    
    # Chaotic-Nix: https://www.nyx.chaotic.cx/
    pkgs-chaotic.url      = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";

    # NixOS-Hardware: https://github.com/NixOS/nixos-hardware
    nixos-hardware.url    = "github:nixos/nixos-hardware/master";

    # NixOS-WSL: https://nix-community.github.io/NixOS-WSL/index.html
    nixos-wsl.url         = "github:nix-community/NixOS-WSL/main";
  };


  outputs = { self, ...} @inputs : let

    linux = "x86_64-linux";
    in {


    nixosConfigurations.nixace = inputs.pkgs-unstable.lib.nixosSystem {
      system = linux;
      specialArgs = {
        pkgs-stable = import inputs.pkgs-stable {
          system = linux;
          config.allowUnfree = true;
        };
      };
      modules = [
        inputs.pkgs-chaotic.nixosModules.default
        ./hardware/nixace.nix
        ./systems/shared/common.nix
        ./systems/shared/audio.nix
        ./systems/nixace.nix
      ];
    };


    nixosConfigurations.nixbox = inputs.pkgs-unstable.lib.nixosSystem {
      system = linux;
      specialArgs = { inherit inputs; };
      modules = [
        inputs.pkgs-chaotic.nixosModules.default
        ./hardware/nixbox.nix
        ./systems/shared/common.nix
        ./systems/shared/audio.nix
        ./systems/nixbox.nix
      ];
    };


    nixosConfigurations.nixwsl = inputs.pkgs-stable.lib.nixosSystem {
      system = linux;
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nixos-wsl.nixosModules.default 
        ./systems/shared/common.nix
        ./systems/nixwsl.nix
      ];
    };


    nixosConfigurations.nixserv = inputs.pkgs-stable.lib.nixosSystem {
      system = linux;
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware/nixserv.nix
        ./systems/shared/common.nix
        ./systems/nixserv.nix
      ];
    };


  };


}
