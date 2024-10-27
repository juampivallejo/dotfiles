{ lib, config, pkgs, ... }:
let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "0xProto" "DroidSansMono" "FiraCode" ];
  };
  theme = {
    name = "Adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  font = {
    name = "FiraCode Nerd Font";
    package = nerdfonts;
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
      gtk3 = {
        extraConfig = {
          gtk-cursor-theme-name = cursorTheme.name;
          gtk-cursor-theme-size = cursorTheme.size;
          gtk-font-name = "${font.name} ${toString font.size}";
          gtk-icon-theme-name = iconTheme.name;
          gtk-theme-name = theme.name;
          gtk-application-prefer-dark-theme = 1;
        };
      };
      gtk4.extraConfig = {
        gtk-cursor-theme-name = cursorTheme.name;
        gtk-cursor-theme-size = cursorTheme.size;
        gtk-font-name = "${font.name} ${toString font.size}";
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

    # Also Apply theming to Flatpak apps # FIXME
    home.file.".local/share/flatpak/overrides/global".text = let
      dirs = [
        "/nix/store:ro"
        "xdg-config/gtk-3.0:ro"
        "xdg-config/gtk-4.0:ro"
        "${config.xdg.dataHome}/icons:ro"
      ];
    in ''
      [Context]
      filesystems=${builtins.concatStringsSep ";" dirs}
    '';

  };
}
