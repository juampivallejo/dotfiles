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

      # Try out 555 driver beta to fix flickering on apps
      # TODO: Move to official when out of beta.
      nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58";
        sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
        sha256_aarch64 = "sha256-7XswQwW1iFP4ji5mbRQ6PVEhD4SGWpjUJe1o8zoXYRE=";
        openSha256 = "sha256-hEAmFISMuXm8tbsrB+WiUcEFuSGRNZ37aKWvf0WJ2/c=";
        settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
        persistencedSha256 = "sha256-lyYxDuGDTMdGxX3CaiWUh1IQuQlkI2hPEs5LI20vEVw=";
        # persistencedSha256 = lib.fakeSha256;  This is to Ignore the Sha if not sure I think
      };
    };
    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };
    environment.systemPackages = with pkgs; [
      libva # Required for Nvidia
    ];
  };

}
