{ ... }:

{
  # Enable Gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true; # GDM login screen
  services.xserver.desktopManager.gnome.enable = true;

  environment.sessionVariables = {
    GTK_THEME = "Arc-Dark";
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
