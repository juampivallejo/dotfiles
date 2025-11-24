{ ... }:

{
  services = {
    # Enable Flatpak
    flatpak.enable = true;
    # Prevent OOM freezing
    earlyoom.enable = true;
    # Disable orca screen reader
    orca.enable = false;
  };

  nix.settings.trusted-users = [ "root" "juampi" ]; # Allow devenv to use cachix
}
