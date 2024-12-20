{ pkgs, lib, config, ... }:

{
  options = {
    kitty.transparency.enable = lib.mkEnableOption "Enables Kitty transparency";
  };

  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs;
      [
        kitty # Terminal
      ];

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

      # There may be a better way to do a conditional
      ${
        if config.kitty.transparency.enable then "background_opacity" else null
      } = "0.35";

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
}
