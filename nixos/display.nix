{ }:
{
  # SDDM Option
  services.displayManager = {
    enable = true;
    sddm = {
      enable = false;
      wayland.enable = true;
      enableHidpi = true;
    };

    cosmic-greeter = {
      enable = true;
    };
  };

  ## Greetd Option
  # services.greetd.enable = false;
  # services.greetd.settings = {
  #   default_session.command = "uwsm start -e -D Hyprland hyprland.desktop";
  #   default_session.user = "juampi";
  # };
}
