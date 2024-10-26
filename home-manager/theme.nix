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
      file = {
        ".config/gtk-4.0/gtk.css".text = ''
          window.messagedialog .response-area > button,
          window.dialog.message .dialog-action-area > button,
          .background.csd{
            border-radius: 0;
          }
        '';
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
        extraCss = ''
          headerbar, .titlebar,
          .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
            border-radius: 0;
          }
        '';
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
  };
}
