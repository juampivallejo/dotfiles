{ ... }:

{
  # Enable Flatpak
  services.flatpak.enable = true;

  services.earlyoom.enable = true; # Prevent OOM freezing
}
