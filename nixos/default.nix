{ ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./auto-upgrade.nix
    ./bluetooth.nix
    ./fonts.nix
    ./gnome.nix
    ./hyprland.nix
    ./i18n.nix
    ./kanata.nix
    ./nvidia.nix
    ./services.nix
    ./sound.nix
    ./vpn.nix
  ];
}
