{ pkgs, ... }:
{
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
