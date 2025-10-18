{ config, pkgs, ... }: {


  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = true; # Fixes wake from sleep bug
    modesetting.enable = true; # Required for Wayland
    nvidiaSettings = true; # accessible via 'nvidia-settings'
    open = false;
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Flatpak icon/font fix
  # https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279
  /*
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
    "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
  };
  */

  services.flatpak.enable = true;
  services.onedrive.enable = true;

  programs.git = {
    enable = true;
    config.user.email = "huffsmith07@gmail.com";
    config.user.name = "itsmetrevor";
  };

  programs.xonsh = {
    enable = true;
    config = builtins.readFile ../dotfiles/xonshrc; 
  };

  environment.systemPackages = with pkgs; [
    helix
    ghostty
    floorp
    brave
    protonvpn
    bitwarden

    kdePackages.breeze
    gnome-tweaks
    
    gnomeExtensions.paperwm
    gnomeExtensions.extension-list
    gnomeExtensions.open-bar
    gnomeExtensions.wallpaper-slideshow
 
  ];

  users.users.trevor.packages = with pkgs; [
    lutris
    protonup-qt
    xivlauncher
    prismlauncher
    
    spotify
    vesktop
    obsidian
  ];

  users.users.trevor = {
    shell = "${pkgs.xonsh}/bin/xonsh";
    isNormalUser = true;
    description = "It's me, Trevor.";
    extraGroups = [ "networkManager" "wheel" ];
    openssh.authorizedKeys.keyFiles = [];
  };

  hardware.xpadneo.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      # extraPkgs = p: [ p.pkgs.adwaita-icon-theme ]; # cursor fix
      extraPkgs = p: [ p.pkgs.kdePackages.breeze ];
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };



  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  hardware.bluetooth.enable = true;
  services.printing.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };


  ##########################################################################
  # This value determines the NixOS release from which autoUpgradethe default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
