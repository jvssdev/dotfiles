{
  pkgs,
  inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = ../wallpapers/nixos-catppuccin-center-small.png;
    base16Scheme = ./catppuccin-mocha.yaml;
    fonts = rec {
      serif = {
        package = pkgs.nerdfonts;
        name = "Hack Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerdfonts;
	name = "Hack Nerd Font";
      };
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; } );
        name = "JetBrains Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-monochrome-emoji;
        name = "Noto Emoji";
      };
      sizes = {
        applications = 11;
        desktop = 14;
        popups = 14;
        terminal = 15;
      };
    };
    #opacity = {
     # terminal = 0.80;
     # applications = 0.90;
      #popups = 0.90;
     # desktop = 0.80;
    #};
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
  };
  fonts = {
    fontconfig.defaultFonts = rec {
      sansSerif = ["Hack Nerd Font"];
      serif = sansSerif;
      emoji = ["Noto Emoji"];
    };
  };
}
