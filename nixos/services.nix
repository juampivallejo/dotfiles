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
}
