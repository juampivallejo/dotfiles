{ pkgs, lib, config, ... }: {

  options = { hyprland.enable = lib.mkEnableOption "Enables Hyprland config"; };

  config = lib.mkIf config.hyprland.enable {

    # Config Symlink
    home.file."./.config/hypr/" = {
      source = ./hypr;
      recursive = true;
    };
    home.file."./.config/scripts/" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
    home.file."./.config/waybar/" = {
      source = ./waybar;
      recursive = true;
    };
    home.file."./.config/dunst/" = {
      source = ./dunst;
      recursive = true;
    };

    home.packages = with pkgs; [
      waybar
      alsa-utils # amixer volume control
      killall # Used in some scripts
      pavucontrol # Audio control with waybar
      dunst # notifications
      dmenu # notification actions
      networkmanagerapplet # (nm-applet) Network and wifi sys tray
      swww # Wallpapers
      libnotify
      slurp # for screenshots
      playerctl # Player control
      # cava # Music visualizer
      pulseaudio # installs pactl useful to swithc audio devices
    ];
  };
}
