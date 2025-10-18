# Home Manager Guides
# https://nix-community.github.io/home-manager/
# https://nixos.wiki/wiki/Home_Manager
# https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager

# Option Documentation:
# https://nix-community.github.io/home-manager/options.xhtml
# https://home-manager-options.extranix.com/  # Option Search

{ config, pkgs, inputs, ... }: {

  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  /* Flatpak Installs
    Lutri
    BoilR
    Steam
    ProtonUp-qt
    Protontricks
    Vesktop
    VSCode
    XIVLauncher
  */

  home.packages = with pkgs; [

    ### Extra Utils ###
    python3

    #helix
    #kitty
    #zsh
    #ohmyzsh
    #yaru
    #roboto
    #fira-code-nerdfont

    lazygit
    gh

    fd
    fzf
    nnn
    ranger
    ripgrep
    tree

    autokey
    bat
    jq
    p7zip
    pandoc
    rclone
    trashy

    btop
    qdirstat

    cht-sh
    python311Packages.howdoi
    tldr
    zeal

    ### Container ###
    distrobox
    docker
    docker-compose
    lazydocker
    podman
    podman-compose

    ### Others ###
    bitwarden
    keepassxc
    obsidian
    thunderbird


  ];

  programs = {

    firefox = {
      enable = true;
      package = pkgs.firefox;
    };

    # https://home-manager-options.extranix.com/?query=helix&release=master
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "dracula";
        editor = {
          line-number = "relative";
          auto-save = true;
          file-picker.hidden = true;
          lsp.display-messages = true;
          cursor-shape.insert = "bar";
          cursor-shape.normal = "block";
          cursor-shape.select = "underline";
        };
        keys.normal =  {
          space.space.s = ":toggle soft-wrap.enable";
          space.space.Q = ":q!";
          space.space.W = ":wq";
          space.space.w = ":write";
          space.space.q = ":quit";
        };
      };
    };

    # https://home-manager-options.extranix.com/?query=kitty&release=master
    kitty = {
      enable = true;
      theme = "Dracula";
      settings = {
        background_opacity = "1.0";
        scrollback_lines = 100000;
        confirm_os_window_close = 0;
      };
    };

    # https://home-manager-options.extranix.com/?query=programs.zsh&release=master
    zsh = {
      enable = true;
      autocd = true;
      history.size = 100000;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/";

      shellAliases = {
        rm="echo Use 'trash', or call 'rm' from bash!";
        update = "sudo nixos-rebuild $1 --impure --flake '/home/trevor/.nixos/#'";
        edit = "$EDITOR ~/.nixos";
        ll = "ls -lh";
        helix = "hx";
        gitl = "lazygit";
        gith = "gh";
        rgrep = "rg";
      };

      oh-my-zsh.enable = true;
      oh-my-zsh.theme = "gnzh";
    };

  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Let Home Manager manage your xsession.
  xsession.enable = true;

}
