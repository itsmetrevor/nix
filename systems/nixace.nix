{ config, pkgs, pkgs-stable, ... }: {


  networking.hostName = "nixace";

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
    shell = pkgs.nushell;
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
  programs.chromium.enable = true;

  environment.systemPackages = with pkgs; [

    fastfetch
    nix-search-cli
    cachix

    bat
    btop
    fd
    fzf
    grex
    ripgrep
    rmtrash
    ttyd
    
    gh # Github CLI
    lazygit
    uv
    # devpod
    # n8n

    evil-helix
    vscodium # cline, roo, kilo
    code-cursor
    windsurf
    zed-editor

    opencode # integrates mcp, integrates nvim

    leetcode-cli

    brave
    bitwarden
    libreoffice
    obsidian # can connect with mcp servers!
    vesktop

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
