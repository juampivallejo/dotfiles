{ pkgs, ... }:

{
  # Enable Gnome
  services.displayManager.gdm.enable = false; # GDM login screen
  services.desktopManager.gnome.enable = true;

  # Enable Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages =
    [ pkgs.libsecret ]; # libsecret API (use secret-tool from the cli)
  security = {
    pam.services.hyprland.enableGnomeKeyring = true;
    pam.services.gdm.enableGnomeKeyring = true;
  };

  environment.sessionVariables = {
    GTK_THEME = "Tokyonight-Dark";
    GTK_ICON_THEME = "MoreWaita";
    GTK_CURSOR_THEME = "BreezeX-RosePine-Linux";
    GTK_COLOR_SCHEME = "prefer-dark";
    XCURSOR_THEME = "BreezeX-RosePine-Linux";
    XCURSOR_SIZE = "24";
  };
  # Gnome Exclude Packages
  environment.gnome.excludePackages = (with pkgs; [
    nautilus
    gnome-tour
    gedit # text editor
    geary # email reader
    gnome-user-docs
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-music
    gnome-weather
    loupe
    gnome-connections
    simple-scan
    snapshot
    totem
    gnome-software
    # gnome-logs
    # gnome-terminal
    # epiphany # web browser
  ]);
}
