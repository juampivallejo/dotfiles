{ pkgs, ... }:
{
  home.sessionVariables = {
      GTK_THEME="Arc-Dark";
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };
}
