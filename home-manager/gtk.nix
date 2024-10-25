{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [
      arc-theme # gtk theme
      rose-pine-icon-theme
    ];

    # FIXME: Cursor on GTK apps not working
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.rose-pine-icon-theme;
      name = "Rose-Pine";
      size = 24;
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
  };
}
