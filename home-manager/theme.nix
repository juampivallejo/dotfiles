{ lib, config, pkgs, ... }:
let
  theme = {
    name = "Tokyonight-Dark";
    package =
      pkgs.tokyonight-gtk-theme.override { colorVariants = [ "dark" ]; };
  };
  font = {
    name = "0xProto Nerd Font";
    package = pkgs.nerd-fonts._0xproto;
    size = 11;
  };
  cursorTheme = {
    name = "BreezeX-RosePine-Linux";
    size = 24;
    package = pkgs.rose-pine-cursor;
  };
  iconTheme = {
    name = "MoreWaita";
    package = pkgs.morewaita-icon-theme;
  };
in {

  config = lib.mkIf config.desktopApps.enable {
    home = {
      packages = with pkgs; [
        # Inputs
        theme.package
        cursorTheme.package
        iconTheme.package
        # Extras
        arc-theme # gtk theme
        font-awesome
        papirus-icon-theme
      ];
      sessionVariables = {
        GTK_THEME = theme.name;
        XCURSOR_THEME = cursorTheme.name;
        XCURSOR_SIZE = "${builtins.toString cursorTheme.size}";
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
      gtk3 = {
        extraConfig = {
          gtk-cursor-theme-name = cursorTheme.name;
          gtk-cursor-theme-size = cursorTheme.size;
          gtk-font-name = "${font.name} ${builtins.toString font.size}";
          gtk-icon-theme-name = iconTheme.name;
          gtk-theme-name = theme.name;
          gtk-application-prefer-dark-theme = 1;
        };
      };
      gtk4.extraConfig = {
        gtk-cursor-theme-name = cursorTheme.name;
        gtk-cursor-theme-size = cursorTheme.size;
        gtk-font-name = "${font.name} ${builtins.toString font.size}";
        gtk-icon-theme-name = iconTheme.name;
        gtk-theme-name = theme.name;
        gtk-application-prefer-dark-theme = 1;
      };
    };

    # Configure ~/config/xsettingsd/xsettingsd.conf themes
    services.xsettingsd = {
      enable = true;
      settings = {
        "Net/ThemeName" = theme.name;
        "Net/IconThemeName" = iconTheme.name;
        "Gtk/CursorThemeName" = cursorTheme.name;
        "Net/EnableEventSounds" = 1;
        "EnableInputFeedbackSounds" = 0;
        "Xft/Antialias" = 1;
        "Xft/Hinting" = 1;
        "Xft/HintStyle" = "hintslight";
        "Xft/RGBA" = "rgb";
      };
    };
  };
}
