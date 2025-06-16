{


  description = "This flake really ties my systems together";


  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";

    #  Pass two extra flags when you run nixos-rebuild for the initial configuration switchover:
    #    sudo nixos-rebuild \
    #    --option extra-substituters https://install.determinate.systems \
    #    --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM= \
    #    --flake . \
    #    switch
    
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
