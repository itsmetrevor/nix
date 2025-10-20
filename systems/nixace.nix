{ config, pkgs, pkgs-stable, ... }: {


  networking.hostName = "nixace";

  # boot.kernelPackages = pkgs-stable.linuxPackages;
  # hardware.microsoft-surface.kernelVersion = "stable";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true;

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.printing.enable = true;
  services.printing.cups-pdf.enable = true;

  services.onedrive.enable = true;

  nix.settings.trusted-users = [ "root" "trevor" ];
  users.users.trevor = {
    isNormalUser = true;
    description = "trevor";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  programs.git = {
    enable = true;
    config.user.email = "huffsmith07@gmail.com";
    config.user.name = "itsmetrevor";
  };

  programs.firefox.enable = true;

  programs.zoxide.enable = true;
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    # transientPrompt.enable = true;
    # transientPrompt.right = "starship module time";
    # transientPrompt.left = "starship module character";
  };
  users.users.trevor.shell = "${pkgs.fish}/bin/fish";

  environment.systemPackages = with pkgs; [

    nix-search-cli
    cachix
    
    bat
    btop
    lsd

    fd
    fzf
    ranger
    ripgrep
    
    evil-helix
    gemini-cli
    gh # Github CLI
    lazygit

    leetcode-cli

    google-chrome
    bitwarden
    libreoffice
    obsidian
    vesktop
    vscode
    warp-terminal

    nerd-fonts.jetbrains-mono
    gnomeExtensions.paperwm
    gnomeExtensions.blur-my-shell
  ];

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];


  ##########################################################################
  # This value determines the NixOS release from which autoUpgradethe default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";


}
