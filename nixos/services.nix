{ ... }:

{
  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable polkit for auth dialogs
  security.polkit.enable = true;
}
