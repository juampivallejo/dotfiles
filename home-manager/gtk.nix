{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs;
      [
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
  };
}
