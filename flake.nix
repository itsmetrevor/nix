{


  description = "This flake really ties my systems together";


  inputs = {
    # Pass two extra flags when you run nixos-rebuild for the initial configuration switchover:
    #   sudo nixos-rebuild \
    #   --option extra-substituters https://install.determinate.systems \
    #   --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM= \
    #   --flake . \
    #   switch
    
    determinate.url     = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    pkgs.url            = "https://flakehub.com/f/NixOS/nixpkgs/0";
    pkgs-unstable.url   = "github:nixos/nixpkgs?ref=nixos-unstable";

    # NixOS-WSL Docs: https://nix-community.github.io/NixOS-WSL/index.html
    nixos-wsl.url       = "github:nix-community/NixOS-WSL/main";
  };


  outputs = { self, determinate, pkgs, pkgs-unstable, nixos-wsl, ... }: {

    nixosConfigurations.nixwsl = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit pkgs-unstable; };
      modules = [
        ./nixwsl/configuration.nix
        nixos-wsl.nixosModules.default 
        determinate.nixosModules.default
      ];
    };

    nixosConfigurations.thinknix = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./thinknix/configuration.nix
        determinate.nixosModules.default
      ];
    };

  };


}
