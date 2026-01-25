{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  config = lib.mkIf config.enableHyprland {

    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
    programs.hyprlock = {
      enable = true; # Enable Lock-screen for hyprland
    };
    services.hypridle = {
      enable = true; # idle support
    };

    environment.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    security = {
      polkit.enable = true;
    };

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # For Hyprland
      kdePackages.dolphin # file explorer
      imv # Imdateage terminal viewer
      wf-recorder # Recorder screen
      wl-clipboard # Clipboard for wayland -> used with wl-copy & wl-paste cli
      cliphist # Clipboard history
      wayshot # screenshot CLI
      swappy # snapshot
      hyprlock # Lock screen
      hyprpicker # color picker
      gpu-screen-recorder-gtk # Screen recording
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default # Cursor theme
    ];

    # Allow gpu-screen-recorder to run as root
    security.wrappers.gsr-kms-server = {
      source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
    };
  };
}
