{


  description = "This flake really ties my systems together";


  inputs = {
    pkgs-stable.url     = "github:nixos/nixpkgs?ref=nixos-25.05";
    pkgs-unstable.url   = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    # Chaotic-Nix: https://www.nyx.chaotic.cx/
    pkgs-chaotic.url    = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # NixOS-Hardware: https://github.com/NixOS/nixos-hardware
    nixos-hardware.url  = "github:nixos/nixos-hardware/master";

    # NixOS-WSL: https://nix-community.github.io/NixOS-WSL/index.html
    nixos-wsl.url       = "github:nix-community/NixOS-WSL/main";
  };


  outputs = { self, ...} @inputs : {

    nixosConfigurations.nixace = inputs.pkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
        ./hardware/nixace.nix
        ./systems/shared/common.nix
        ./systems/shared/audio.nix
        ./systems/nixace.nix
      ];
    };

    nixosConfigurations.nixbox = inputs.pkgs-unstable.lib.nixosSystem {
      system = "x86_64-linux";
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
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        inputs.nixos-wsl.nixosModules.default 
        ./systems/shared/common.nix
        ./systems/nixwsl.nix
      ];
    };

    nixosConfigurations.nixserv = inputs.pkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware/nixserv.nix
        ./systems/shared/common.nix
        ./systems/nixserv.nix
      ];
    };

  };


}
