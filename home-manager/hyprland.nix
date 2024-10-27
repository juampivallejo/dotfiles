{ pkgs, lib, config, pkgs-unstable, ... }: {

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

    home.packages = with pkgs; [
      pkgs-unstable.waybar
      pavucontrol # Audio control with waybar
      swww # Wallpapers
      libnotify
      slurp # for screenshots
    ];
  };
}
