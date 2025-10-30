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

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [ ];

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
