{ pkgs, lib, config, ... }: {
  options = { nvidia.enable = lib.mkEnableOption "Enables Nvidia drivers"; };

  config = lib.mkIf config.nvidia.enable {

    services.xserver = { videoDrivers = [ "nvidia" ]; };
    environment.systemPackages = with pkgs;
      [
        libva # Required for Nvidia
      ];

    hardware = {
      # OpenGL
      opengl.enable = true;

      nvidia = {
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
        # nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "555.58.02";
          sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
          sha256_aarch64 =
            "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
          openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
          settingsSha256 =
            "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
          persistencedSha256 = lib.fakeSha256; # Ignore Sha256
        };
      };
    };
  };

}
