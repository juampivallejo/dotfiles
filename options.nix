{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

{
  options = {
    # Example option for debugging
    enableFastFetch = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the FastFetch cli tool";
    };

    enableHyprland = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Hyprland window manager and related components.";
    };

    desktopApps = {
      enable = lib.mkEnableOption "Enables desktop Apps";
      kitty = lib.mkEnableOption "Enables kitty terminal";
      ghostty = lib.mkEnableOption "Enables ghostty terminal";
    };

    nvidiaDrivers = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable NVIDIA drivers and related settings.";
      };
    };

    isNixOS = mkOption {
      type = types.bool;
      default = false;
      description = "Apply configuration tweaks for NixOS environments.";
    };

    isWSL = mkOption {
      type = types.bool;
      default = false;
      description = "Apply configuration tweaks for WSL environments.";
    };

    isDarwin = mkOption {
      type = types.bool;
      default = false;
      description = "Enable macOS-specific configuration for nix-darwin.";
    };

    enableHomeRowMod = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Home Row keyboard modifier";
    };
  };
}
