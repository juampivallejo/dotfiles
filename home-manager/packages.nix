{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Wallpapers
    swww

    # Software
    obsidian

    # Virtualization
    virtualbox

    # TODO: Move packages
  ];
}
