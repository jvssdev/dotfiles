#e This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./wezterm/default.nix
    ./git/default.nix
    ./zsh/default.nix
    ./waybar/default.nix
    ./hyprland/default.nix
    ./fuzzel/default.nix
    ./yazi/default.nix
    ./wlogout/default.nix
    ./kitty/default.nix
    ./swaylock/default.nix
    ./mako/default.nix
    ./stylix/default.nix
    ./gtk/default.nix
    ./cliphist/default.nix
    ./tmux/default.nix
    ./hypridle/default.nix
    ./brave/default.nix
    ./obsidian/default.nix
  ];

  home = {
    username = "joaov";
    homeDirectory = "/home/joaov";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  xdg.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    python311
    python311Packages.pip

    #Neovim
    lldb
    tree-sitter
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages.prettier
    nodePackages_latest.vscode-langservers-extracted
    nixd
    nixpkgs-fmt
    lua-language-server
    stylua
    gopls
    zls
    lua
    java-language-server
    luajitPackages.luarocks
    markdownlint-cli
    postgresql
    sqls
    python311Packages.psycopg2
  ];

  # Neovim configuration
  programs.neovim = {
    viAlias = true;
    withPython3 = true;
    withNodeJs = true;
    extraPython3Packages = (ps: with ps; [
      pynvim
     psycopg2
    ]);
    plugins = with pkgs.vimPlugins; [ vimPlugins.telescope.nvim vimPlugins.nvim-treesitter];
    extraPackages = with pkgs; [];

  };

  home.file = {
    ".config/nvim/init.lua" = {
      source = ./neovim/init.lua;
    };
    ".config/nvim/lua" = {
      source = ./neovim/lua;
      target = ".config/nvim/lua";
    };
  };
}

