{ pkgs, lib, config, ... }: {
  options = { nvidia.enable = lib.mkEnableOption "Enables Nvidia drivers"; };

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

      # Try out 555 driver beta to fix flickering on apps
      # TODO: Move to official when out of beta.
      nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58.02";
        sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
        sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
        openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
        settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
        persistencedSha256 =
          "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
        # persistencedSha256 = lib.fakeSha256;  This is to Ignore the Sha if not sure I think
      };
    };
    services.xserver = { videoDrivers = [ "nvidia" ]; };
    environment.systemPackages = with pkgs;
      [
        libva # Required for Nvidia
      ];
  };

}
