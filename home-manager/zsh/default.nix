{ config, pkgs, ... }:

let
  zsh_plugins = [
    { name = "zsh-autosuggestions"; src = pkgs.zsh-autosuggestions; file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh"; }
    { name = "zsh-completions"; src = pkgs.zsh-completions; file = "share/zsh-completions/zsh-completions.zsh"; }
    { name = "zsh-syntax-highlighting"; src = pkgs.zsh-syntax-highlighting; file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; }
    { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
  ];
in {
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    shellAliases = {
      ls = "ls --color";
    };
    initExtra = ''
      bindkey -e

  if [ -f ~/.env ]; then
      export $(cat ~/.env | xargs)
  fi


      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
      
    export PATH="/nix/store/hyppxdhgqx7nbg394j97yhmi6vizl074-python3-3.11.9/bin:$PATH"
    export PATH="/nix/store/ilkfhnqz4xczrliqjva8770x2svbfznd-nodejs-20.14.0/bin:$PATH"
    export PATH="/nix/store/jdyb7l90301ri8zcipdapc0dhsfq0qli-perl-5.38.2/bin:$PATH"
    export PATH="/nix/store/fsym6fc0v8njmvf9gydy21vi9ph3c9fr-ruby-3.1.5/bin:$PATH"
      export PATH=${pkgs.python311Packages.pip}/bin:$PATH
      export PATH=${pkgs.python311}/bin:$PATH
      export PATH="$HOME/.nix-profile/bin:$PATH"
      export EDITOR=nvim
      export PATH="$PATH:"${pkgs.wezterm}/bin/wezterm""
      export PATH=$PATH:/nix/var/nix/profiles/default/bin

      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set descriptions format to enable group support
      # NOTE: don't use escape sequences here, fzf-tab will ignore them
      zstyle ':completion:*:descriptions' format '[%d]'
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      zstyle ':completion:*' menu no
      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'
      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'
    '';
    plugins = zsh_plugins;
  };
}
