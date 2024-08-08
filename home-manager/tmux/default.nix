{ pkgs, ... }:
let
  resurrectDirPath = "~/.config/tmux/resurrect";
  generatedConfigFilePath = "~/.config/tmux/tmux.conf"; # Generated by extraConfig
  tmux-nerd-font-window-name = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name.tmux";
    version = "unstable-2023-08-22";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "c2e62d394a290a32e1394a694581791b0e344f9a";
      sha256 = "stkhp95iLNxPy74Lo2SNes5j1AA4q/rgl+eLiZS81uA=";
    };
  };

in
{

programs.tmux = {
  enable = true;
  secureSocket = false;
  terminal = "screen-256color";
  disableConfirmationPrompt = true;
  prefix = "C-a";
  keyMode = "vi";
  baseIndex = 1;
  clock24 = true;
  sensibleOnTop = true;

   plugins = with pkgs.tmuxPlugins; [
      nord

     {
        plugin = resurrect;
        extraConfig = ''

          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-strategy-vim 'session'

          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-dir ${resurrectDirPath}
          set -g @resurrect-hook-post-save-all 'sed -i -E "s|(pane.*nvim\s*:)[^;]+;.*\s([^ ]+)$|\1nvim \2|" ${resurrectDirPath}/last'
        '';
    }

       {
        plugin = vim-tmux-navigator;
    }
       {
        plugin = yank;
    }
       {
        plugin = tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-command 'tmux set-buffer -- {} && tmux display-message "Copied {}" && printf %s {} | xclip -i -selection clipboard'
          set -g @thumbs-key C-y
        '';
    }
  
     {
     plugin = continuum;
     extraConfig = ''
       set -g @continuum-restore 'on'
       set -g @continuum-save-interval '10'
     '';
    }
    {
        plugin = tmux-nerd-font-window-name;
        extraConfig = ''
            set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'
        '';
    }
  ];

  extraConfig = ''
    run-shell "if [ ! -d ${resurrectDirPath} ]; then tmux new-session -d -s init-resurrect; ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh; fi"

    # kill a session
    bind-key X kill-session
    set -g status-left-length 30

    set-option -g detach-on-destroy off

    set-option -g allow-rename off

    set-option -g renumber-windows on

    # Set easier window split keys
    bind-key v split-window -h
    bind-key h split-window -v

    # Enable mouse mode(tmux 2.1++)
    setw -g mouse on

    set-option -g status-position top

   
    bind-key g new-window 'lazygit; tmux kill-pane'

    bind-key -r i run-shell 'tmux neww cheat-sh'
    # Easier move of windows
    bind-key -r Home swap-window -t - \; select-window -t -
    bind-key -r End swap-window -t + \; select-window -t +


    # switch to last session
    bind-key L switch-client -l

    # Pane to window
    unbind !
    bind-key w break-pane

    set -g set-titles 'on'

    set -g set-titles-string '#{pane_title}'

    bind -n S-Left previous-window
    bind -n S-Right next-window

    unbind z
    bind-key f resize-pane -Z

    bind-key -T copy-mode-vi v send-keys -X begin-selection
    
    # Creating new windows and sessions
    bind Enter new-window -a
    bind-key -r o command-prompt -p "Name of new session:" "new-session -s '%%'"

    # evaluate/reload config
    bind-key e source-file ${generatedConfigFilePath} \; display-message "${generatedConfigFilePath} evaluated."

   '';
  };

}
