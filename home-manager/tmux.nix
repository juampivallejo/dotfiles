{ pkgs, ... }: {
  home.file."./.config/tmux/" = {
    source = ./tmux;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    clock24 = true;
    historyLimit = 100000;
    escapeTime = 50;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "

          set -g @catppuccin_window_default_fill "none"

          set -g @catppuccin_window_current_fill "all"

          set -g @catppuccin_status_modules_right "session directory user"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"

          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
      tmuxPlugins.yank
    ];
    extraConfig = ''
      # Clear
      bind C-l send-keys 'C-l'
      # Shift alt to navigate windows
      bind -n M-H previous-window
      bind -n M-L next-window
      # Open panes in CWD
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      # Key bindings
      bind-key -r i run-shell "tmux neww ~/.config/tmux/tmux-cht.sh"
      bind-key -r o run-shell "tmux neww ~/.config/tmux/sessionizer.sh"
      # Enable scrolling
      set -g mouse
      set-window-option -g mode-keys vi
    '';
  };
}
