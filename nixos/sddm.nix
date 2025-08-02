{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sddm-astronaut ];

  services.displayManager.sddm = {
    enable = false;
    wayland = true;
    theme = "hyprland_kath";
  };
}
