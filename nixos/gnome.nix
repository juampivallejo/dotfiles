{ pkgs, ... }:

{
  # Enable Gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true; # GDM login screen
  services.xserver.desktopManager.gnome.enable = true;

  # Enable Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages =
    [ pkgs.libsecret ]; # libsecret API (use secret-tool from the cli)
  security = {
    pam.services.hyprland.enableGnomeKeyring = true;
    pam.services.gdm.enableGnomeKeyring = true;
  };

  environment.sessionVariables = {
    GTK_THEME = "Nordic";
    GTK_ICON_THEME = "MoreWaita";
    GTK_CURSOR_THEME = "BreezeX-RosePine-Linux";
    GTK_COLOR_SCHEME = "prefer-dark";
    XCURSOR_THEME = "BreezeX-RosePine-Linux";
    XCURSOR_SIZE = "24";
  };
  # Gnome Exclude Packages
  # environment.gnome.excludePackages = (with pkgs; [
  #   gnome-tour
  # ]) ++ (with pkgs.gnome; [
  #       gnome-terminal
  #       gedit # text editor
  #       epiphany # web browser
  #       geary # email reader
  #       tali # poker game
  #       iagno # go game
  #       hitori # sudoku game
  #       atomix # puzzle game
  # ]);
}
