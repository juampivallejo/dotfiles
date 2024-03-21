{ pkgs, ... }:

{
  # Enable Hyprland

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    # OpenGL
    opengl.enable = true;
    # Most wayland compositors need this
    nvidia.modesetting.enable = true;
    # Enable settings menu
    nvidia.nvidiaSettings = true;
    # Enabling this to fix suspend issues
    nvidia.powerManagement.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # For Hyprland
    libva # Required for Nvidia
    dunst # Notifications
    imv # Imdateage terminal viewer
    wf-recorder # Recorder screen
    wl-clipboard # Clipboard for wayland -> used with wl-copy & wl-paste cli
    wayshot # screenshot CLI
    swappy # snapshot
  ];
}
