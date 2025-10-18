{ config, pkgs, ... }:

{

  networking.hostName = "thinknix";
  
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
    config = builtins.readFile ../dotfiles/xonshrc;
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

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ ];

  
  ##########################################################################
  # This value determines the NixOS release from which autoUpgradethe default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";


}
