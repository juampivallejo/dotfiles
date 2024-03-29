{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arc-theme # gtk theme
  ];
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
