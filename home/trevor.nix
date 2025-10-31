{ config, pkgs, ...}: {

  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  programs.ghostty.enable = true;
  programs.fish.enable = true;

	programs.zoxide = {
	  enable = true;
	  enableFishIntegration = true;
	};

	programs.atuin = {
	  enable = true;
	  enableFishIntegration = true;
	};

	programs.starship = {
	  enable = true;
	  enableFishIntegration = true;
	};

	programs.yazi = {
	  enable = true;
	  enableFishIntegration = true;
	};

	home.packages = with pkgs; [

		fastfetch
		nix-search-cli
		cachix

		bat
		btop
		fd
		fzf
		grex
		lsd
		ripgrep
		rmtrash
		ttyd

		uv
		direnv
		docker
		docker-compose
		lazydocker
		lazygit
		devpod
		n8n

		evil-helix
		vscodium
		code-cursor
		windsurf
		zed-editor

		opencode
		gemini-cli
		qwen-code

		leetcode-cli

		bitwarden
		libreoffice
		obsidian
		vesktop
		
		nerd-fonts.jetbrains-mono
		gnomeExtensions.paperwm
		gnomeExtensions.blur-my-shell
	];

	home.stateVersion = "25.05";
	programs.home-manager.enable = true;

}
