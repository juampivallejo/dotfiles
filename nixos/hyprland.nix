{ pkgs, lib, config, rose-pine-hyprcursor, ... }:

{
  options = { hyprland.enable = lib.mkEnableOption "Enables Hyprland WM"; };

  config = lib.mkIf config.hyprland.enable {
    # Enable Hyprland

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.hyprlock = {
      enable = true; # Enable Lock-screen for hyprland
    };
    services.hypridle.enable =
      true; # Enable idle service to lock or turn off screen after timeout

    environment.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
    hardware = {
      # OpenGL
      opengl.enable = true;
    };

    security = { polkit.enable = true; };

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart =
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # For Hyprland
      imv # Imdateage terminal viewer
      wf-recorder # Recorder screen
      wl-clipboard # Clipboard for wayland -> used with wl-copy & wl-paste cli
      cliphist # Clipboard history
      wayshot # screenshot CLI
      swappy # snapshot
      hyprlock # Lock screen
      hyprdim # Automatically dims windows when switching between them
      hyprpicker # color picker
      rose-pine-hyprcursor.packages.${pkgs.system}.default # Cursor theme
    ];

  };
}
