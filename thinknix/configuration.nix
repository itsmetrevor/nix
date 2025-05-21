{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    helix

    bat
    ripgrep
    lazygit
    docker-compose

    btop
  ];

  programs.git = {
    enable = true;
    config.user.email = "huffsmith07@gmail.com";
    config.user.name = "itsmetrevor";
  };

  virtualisation.docker = {
    enable = true;
  };

  programs.xonsh = {
    enable = true;
  };

  users.users.trevor = {
    isNormalUser = true;
    description = "Trevor";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = "${pkgs.xonsh}/bin/xonsh";
  };

  environment.variables = {
    EDITOR = "hx";
  };

  services.getty.autologinUser = "trevor";

  services.openssh.enable = true;

  networking.networkmanager.enable = true;
  networking.hostName = "thinknix";
  networking.firewall = {
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
  };

  system.autoUpgrade = {
    enable = true;
    dates = "07:00";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASURMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  system.stateVersion = "24.11";
}
