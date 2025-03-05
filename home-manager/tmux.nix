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
        plugin = tmuxPlugins.tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_transparent 1

          # Number styles
          set -g @tokyo-night-tmux_window_id_style fsquare
          set -g @tokyo-night-tmux_pane_id_style hsquare
          set -g @tokyo-night-tmux_zoom_id_style dsquare

          # Icon styles
          # set -g @tokyo-night-tmux_terminal_icon 
          # set -g @tokyo-night-tmux_active_terminal_icon 

          # Window Styles
          set -g @tokyo-night-tmux_show_datetime 1
          set -g @tokyo-night-tmux_date_format DMY
          set -g @tokyo-night-tmux_time_format 24H

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

      # kill pane without confirm
      bind X kill-pane

      # Key bindings
      bind-key -r i run-shell "tmux neww ~/.config/tmux/tmux-cht.sh"
      bind-key -r o run-shell "tmux neww ~/.config/tmux/sessionizer.sh"

      # Enable scrolling
      set -g mouse
      set-window-option -g mode-keys vi
    '';
  };
}
