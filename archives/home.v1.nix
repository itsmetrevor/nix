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
  
  fonts.fontconfig.enable = false;

  home.packages = with pkgs; [
    libsForQt5.bismuth
    bitwarden
    discord
    fastfetch
    firefox
    keepassxc
    mediawriter
    thunderbird
    vlc
    
    graalvm-ce
    lutris
    mangohud
    protontricks
    protonup-ng
    protonup-qt
    steam
    winetricks
    wineWowPackages.unstable

    direnv
    distrobox
    podman
    podman-compose

    lazygit
    gh # Github CLI

    fd # Better Find
    fzf
    bat
    jq # Json Processor
    p7zip
    ranger
    ripgrep
    pandoc
    nb
    dejsonlz4 # Firefox bookmarks decompressor
    ollama
    w3m
    obsidian
    
    btop

    cht-sh
    tldr
  ];

  programs = {

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
          space.space.W = ":toggle soft-wrap.enable";
          space.space.Q = ":wq";
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

    # https://home-manager-options.extranix.com/?query=tmux&release=master
    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      shell = "zsh";
      terminal = "xterm-kitty";
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
