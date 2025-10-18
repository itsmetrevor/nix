{ config, pkgs, pkgs-unstable, ... }: {


  networking.hostName = "nixace";
  hardware.microsoft-surface.kernelVersion = "stable";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.printing.enable = true;
  services.printing.cups-pdf.enable = true;

  services.onedrive.enable = true;

  users.users.trevor = {
    isNormalUser = true;
    description = "trevor";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";

    WARP_ENABLE_WAYLAND = 1;
  };

  programs.git = {
    enable = true;
    config.user.email = "huffsmith07@gmail.com";
    config.user.name = "itsmetrevor";
  };

  programs.firefox.enable = true;
  programs.zoxide.enable = true;
  programs.xonsh.enable = true;
  users.users.trevor.shell = "${pkgs.xonsh}/bin/xonsh";

  environment.systemPackages = with pkgs; [

    nix-search-cli
    
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
    age

    leetcode-cli

    google-chrome
    bitwarden
    libreoffice
    obsidian
    vesktop
    vscode

    nerd-fonts.jetbrains-mono
    gnomeExtensions.paperwm

    (warp-terminal.override { waylandSupport = true; })
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
