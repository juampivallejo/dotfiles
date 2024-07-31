{ pkgs, lib, config, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables Hyprland WM";
  };

  config = lib.mkIf config.hyprland.enable {
    # Enable Hyprland

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.hyprlock = {
      enable = true; # Enable Lock-screen for hyprland
    };
    services.hypridle.enable = true; # Enable idle service to lock or turn off screen after timeout

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

    environment.systemPackages = with pkgs; [
      # For Hyprland
      dunst # Notifications
      imv # Imdateage terminal viewer
      wf-recorder # Recorder screen
      wl-clipboard # Clipboard for wayland -> used with wl-copy & wl-paste cli
      wayshot # screenshot CLI
      swappy # snapshot
      hyprlock # Lock screen
    ];
  };
}
