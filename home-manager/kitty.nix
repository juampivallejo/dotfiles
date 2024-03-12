{ ... }: {

  programs.kitty.enable = true;
  programs.kitty.font.name = "FiraCode Nerd Font";
  programs.kitty.font.size = 12;

  programs.kitty.keybindings = {
    "ctrl+c" = "copy_or_interrupt";
  };

  programs.kitty.settings = {
    # Usage
    copy_on_select = true;
    editor = "vim";
    confirm_os_window_close = 0;

    # Appearance
    background_opacity = ".55";

   # Performance
    repaint_delay = 8;
  };

  programs.kitty.shellIntegration.enableZshIntegration = true;
  programs.kitty.shellIntegration.mode = "";

  # Theme
  programs.kitty.theme = "Catppuccin-Mocha";
}
