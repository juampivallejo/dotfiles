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
        version = "555.52.04";
        sha256_64bit = "sha256-nVOubb7zKulXhux9AruUTVBQwccFFuYGWrU1ZiakRAI=";
        sha256_aarch64 = "sha256-Kt60kTTO3mli66De2d1CAoE3wr0yUbBe7eqCIrYHcWk=";
        openSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
        settingsSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
        persistencedSha256 = lib.fakeSha256;
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
