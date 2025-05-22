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
    gh # Github CLI
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

  users.users.trevor.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE4ieX+67TgNa5uf3eKxhDfBNKysUAszNh32UUvFzyO2zZ0e2voxL42KzgFJLU3FKRxBMdPmiescdfE/VVR2WzJkNs9k97x72GtH+aFFfU3El3DO5A0HowyE/bIXLeJQpQ0kFYV/djibd6UbkXOuQ2l/6XIdH9l1fEWOoltnpYgSh0pYT+sQQjtD8trmzY3iN/YSRiGlxUBdeC8CmYcFPiLQdU9oNsFTMMQ5N0ZANqU8lCqt8nrvqq5sBkXmMIxtLAxK5qVwp+DwmZiVxnOOFuOYs6HG1zDbuhug9tT1+2WercRxFdeJEnM/CH/BJ4/ek9raC+6EpfP+lwC9Nf+nRiNgJwag0RWNe8By0JpanDh2hMdegqZQjO0sG8Ulx96nCB27UZrWJLg7KYObXGM66kULoYEKJu0qL5rgaExVqIag7so/nxJL+LqGVyLMIybshLRZkH+06AQGloWRhO+gJ8TKyX/Au5dG0Eihi32wHHWkDtqT35LgQTtq+QT5LOcHk="
  ];

  services.fail2ban.enable = true;
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  environment.variables = {
    EDITOR = "hx";
  };

  networking.networkmanager.enable = true;
  networking.hostName = "thinknix";
  networking.firewall = {
    allowedTCPPorts = [ 22 ];
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
