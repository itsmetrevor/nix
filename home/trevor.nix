{ config, pkgs, ...}:

{

  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  programs.ghostty.enable = true;
  programs.nushell.enable = true;

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


	home.stateVersion = "25.05";
	programs.home-manager.enable = true;

}
