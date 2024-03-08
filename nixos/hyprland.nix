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
  };

  environment.systemPackages = with pkgs; [
    # For Hyprland
    libva # Required for Nvidia
    dunst # Notifications
    hyprpaper # Wallpaper
    imv # Image terminal viewer
  ];
}
