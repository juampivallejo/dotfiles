{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Wallpapers
    swww

    # Software
    rofi-wayland  # Alternative App launcher
    obsidian
    calibre

    # Virtualization
    virtualbox

    # TODO: Move packages
  ];
}
