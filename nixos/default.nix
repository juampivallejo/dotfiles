{ ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./auto-upgrade.nix
    ./bluetooth.nix
    ./gnome.nix
    ./hyprland.nix
    ./i18n.nix
    ./nvidia.nix
    ./services.nix
    ./sound.nix
    ./vpn.nix
  ];
}
