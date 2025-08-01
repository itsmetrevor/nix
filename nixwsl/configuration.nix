# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
# https://nix-community.github.io/NixOS-WSL/
# https://nixos.wiki/wiki/WSL

{ config, lib, pkgs, pkgs-unstable, ... }:

{
  wsl = {
  # https://nix-community.github.io/NixOS-WSL/options.html
    enable = true;
    defaultUser = "trevor";
    interop.includePath = false;
    docker-desktop.enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;
  };

  networking.hostName = "nixwsl";

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.autoUpgrade = {
    enable = true;
    dates = "07:00";
    fixedRandomDelay = true;
  };

  virtualisation.podman.enable = true;

  programs.git = {
    enable = true;
    config.user.email = "huffsmith07@gmail.com";
    config.user.name = "itsmetrevor";
  };

  programs.xonsh = {
    enable = true;
    config = builtins.readFile ../dotfiles/xonshrc;
  };

  programs.zoxide.enable = true;

  environment.variables = {
    EDITOR = "hx";
    _ZO_DOCTOR = 0; # Remove zoxide error check (false positive)
  };

  environment.systemPackages = with pkgs; [

    gemini-cli
    evil-helix         # https://github.com/usagi-flow/evil-helix
    neovim
    zellij

    podman-compose

    gcc
    gnumake

    unzip
    fd
    fzf
    bat
    eza
    lsd
    ripgrep
    btop
    lazygit
    gh                 # Github CLI
    ranger
    rmtrash
    pandoc
 
    packwiz
  ];

  users.users.trevor = {
    shell = "${pkgs.xonsh}/bin/xonsh";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
