{ lib, config, pkgs, ... }:
let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "0xProto" "DroidSansMono" "FiraCode" ];
  };
  theme = {
    name = "rose-pine-gtk";
    package = pkgs.rose-pine-gtk-theme;
  };
  font = {
    name = "FiraCode Nerd Font";
    package = nerdfonts;
    size = 11;
  };
  cursorTheme = {
    name = "rose-pine-cursor";
    size = 16;
    package = pkgs.rose-pine-cursor;
  };
  iconTheme = {
    name = "rose-pine-icons";
    package = pkgs.rose-pine-icon-theme;
  };
in {

  config = lib.mkIf config.desktopApps.enable {
    home = {
      packages = with pkgs; [
        # Inputs
        theme.package
        font.package
        cursorTheme.package
        iconTheme.package
        # Extras
        arc-theme # gtk theme
        font-awesome
        papirus-icon-theme
      ];
      sessionVariables = {
        XCURSOR_THEME = cursorTheme.name;
        XCURSOR_SIZE = "${toString cursorTheme.size}";
      };
      pointerCursor = {
        name = cursorTheme.name;
        package = cursorTheme.package;
        size = cursorTheme.size;
        gtk.enable = true;
        x11.enable = true;
      };
    };

    fonts.fontconfig.enable = true;
    gtk = {
      inherit font cursorTheme iconTheme;
      theme.name = theme.name;
      enable = true;
    };
  };
}
