{ pkgs, lib, config, ... }: {

  config = lib.mkIf config.nvidiaDrivers.enable {

    programs.steam.enable = true;
    services.xserver = { videoDrivers = [ "nvidia" ]; };
    environment.systemPackages = with pkgs;
      [
        libva # Required for Nvidia
      ];

    hardware = {
      nvidia = {
        open = true;
        # Most wayland compositors need this
        modesetting.enable = true;
        # Enable settings menu
        nvidiaSettings = true;

        # Enabling this to fix suspend issues
        powerManagement.enable = true;
        # powerManagement.finegrained = true;

        # Select Nvidia Package Version
        # nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
        # nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        # package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };

}
