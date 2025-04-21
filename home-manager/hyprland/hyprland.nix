{ pkgs, lib, config, ... }: {

  config = lib.mkIf config.enableHyprland {

    # Config Symlink
    xdg.configFile."hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.xdg.configHome}/dotfiles/home-manager/hyprland/hypr";
      recursive = true;
    };
    xdg.configFile."scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };

    xdg.configFile."waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.xdg.configHome}/dotfiles/home-manager/hyprland/waybar";
      recursive = true;
    };
    xdg.configFile."dunst" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.xdg.configHome}/dotfiles/home-manager/hyprland/dunst";
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
      cava # Music visualizer
      pulseaudio # installs pactl useful to swithc audio devices
    ];
  };
}
