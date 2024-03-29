{ pkgs, lib, config, ... }:
{
  options = {
    nvidia.enable = lib.mkEnableOption "Enables Nvidia drivers";
  };

  config = lib.mkIf config.nvidia.enable {
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
    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };
    programs.hyprland = lib.mkIf config.hyprland.enable {
      enableNvidiaPatches = true;
    };
    environment.systemPackages = with pkgs; [
      libva # Required for Nvidia
    ];
  };

}
