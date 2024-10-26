{ lib, config, pkgs, ... }:
let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "0xProto" "DroidSansMono" "FiraCode" ];
  };
  theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  font = {
    name = "FiraCode Nerd Font";
    package = nerdfonts;
    size = 11;
  };
  cursorTheme = {
    name = "Rose-Pine";
    size = 24;
    package = pkgs.rose-pine-cursor;
  };
  iconTheme = {
    name = "Rose-Pine";
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
      pointerCursor = cursorTheme // { gtk.enable = true; };
    };

    fonts.fontconfig.enable = true;
    gtk = {
      inherit font cursorTheme iconTheme;
      theme.name = theme.name;
      enable = true;
    };
  };
}
