{ pkgs, lib, config, ... }:

let
  terminalConfigs = {
    kitty = {
      # kitty-specific config
      home.packages = with pkgs; [ kitty ];
      programs.kitty.enable = true;
      programs.kitty.font.name = "FiraCode Nerd Font";
      programs.kitty.font.size = 12;

      programs.kitty.keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "kitty_mod+h" = "kitty_scrollback_nvim";
        "kitty_mod+g" =
          "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
      };

      programs.kitty.settings = {
        # Usage
        copy_on_select = true;
        editor = "vim";
        confirm_os_window_close = 0;
        # Appearance
        hide_window_decorations = true;
        background_opacity = "0.35";

        # Performance
        repaint_delay = 8;

        # Nvim Scrollback with ctrl+shift+h
        allow_remote_control = "yes";
        listen_on = "unix:/tmp/kitty";
        shell_integration = "enabled";
        # kitty-scrollback.nvim Kitten alias
        action_alias =
          "kitty_scrollback_nvim kitten /home/juampi/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py";
      };

      programs.kitty.shellIntegration.enableZshIntegration = true;
      programs.kitty.shellIntegration.mode = "";

      # Theme
      programs.kitty.themeFile = "tokyo_night_night";
    };
    ghostty = {
      # ghostty-specific config
      home.packages = with pkgs; [ ghostty ];
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          theme = "tokyonight";
          font-size = 14;
          window-decoration = false;
          background-opacity = 0;
          confirm-close-surface = false;
          gtk-single-instance = true;
        };
      };
    };
  };
in {
  config = lib.mkIf config.desktopApps.enable (lib.mkMerge [
    (lib.mkIf config.desktopApps.kitty terminalConfigs.kitty)
    (lib.mkIf config.desktopApps.ghostty terminalConfigs.ghostty)
  ]);
}
