{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ly uwsm ];

  services.displayManager.sddm = {
    enable = false;
    wayland = true;
    theme = "hyprland_kath";
  };

  services.displayManager.ly = {
    enable = true;
    wayland = true;
  };
}
