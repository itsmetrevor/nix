{ config, pkgs, ...}:

{

  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  programs.ghostty.enable = true;
  programs.nushell.enable = true;
  programs.git.enable = true;

	programs.zoxide = {
	  enable = true;
	  enableNushellIntegration = true;
	};

	programs.atuin = {
	  enable = true;
	  enableNushellIntegration = true;
	};

	programs.carapace = {
	  enable = true;
	  enableNushellIntegration = true;
	};

	programs.starship = {
	  enable = true;
	  enableNushellIntegration = true;
	};

	programs.yazi = {
	  enable = true;
	  enableNushellIntegration = true;
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
		ripgrep
		rmtrash
		ttyd

		gh
		lazygit
		uv
		docker
		docker-compose
		lazydocker
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

		brave
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
