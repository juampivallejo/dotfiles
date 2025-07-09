{ pkgs, lib, config, ... }: {

  config = lib.mkIf config.enableHyprland {

    # Configure Hyprland to use Systemd
    wayland.windowManager.hyprland = {
      systemd.enable = true; # Enable systemd integration for hyprland
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    services.swww.enable = true;
    services.hyprpolkitagent.enable = true;
    services.dunst = {
      enable = true; # Notification service
      configFile = ./dunst/dunstrc;
    };
    services.network-manager-applet.enable = true; # Network sys tray
    services.cliphist.enable = true;

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

    home.packages = with pkgs; [
      alsa-utils # amixer volume control
      killall # Used in some scripts
      pavucontrol # Audio control with waybar
      dmenu # notification actions
      swww # Wallpapers
      libnotify
      slurp # for screenshots
      playerctl # Player control
      cava # Music visualizer
      pulseaudio # installs pactl useful to swithc audio devices
      bluetui # Bluetooth TUI
    ];
  };
}
